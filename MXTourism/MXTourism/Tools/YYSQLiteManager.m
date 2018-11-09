//
//  YYSQLiteManager.m
//  CyhDB
//
//  Created by YY on 2017/6/22.
//  Copyright © 2017年 Macx. All rights reserved.
//
#import <objc/runtime.h>
#import "YYSQLiteManager.h"
#import <sqlite3.h>
static YYSQLiteManager * YYDBmanager;

@interface YYSQLiteManager ()
@property (nonatomic,strong)NSMutableArray *allKeys;
@end
@implementation YYSQLiteManager
{
    NSString * path;
    sqlite3_stmt *stmt;
    sqlite3 *database;
    NSString *_tableName;

}

+ (instancetype)shareBaseDB
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        YYDBmanager = [YYSQLiteManager new];

    });
    
    
    return YYDBmanager;
    
}

- (BOOL)createDB:(NSString *)DBPath
{
    _allKeys=[NSMutableArray array];
    BOOL flag;
    path = DBPath;
    if (sqlite3_open([path UTF8String], &database)!= SQLITE_OK) {
        
        NSLog(@"数据库打开失败");
        
        flag = NO;
    }
    else
    {
        flag = YES;
                NSLog(@"数据库打开成功");
        
        
    }
    
    return flag;
}
-(void)createSQLiteName:(NSString *)name{
    NSString *pathStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    pathStr=[pathStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",name]];
    BOOL flag;
    path = pathStr;
    if (sqlite3_open([path UTF8String], &database)!= SQLITE_OK) {
        
        NSLog(@"数据库打开失败");
        
        flag = NO;
    }
    else
    {
        flag = YES;
        NSLog(@"数据库打开成功");
        
        
    }
    
//    return flag;
}

- (BOOL)createTable:(NSString *)Sqlstr
{
    BOOL flag;
    //创建数据库表
    NSString *createSQL = Sqlstr;
    
    char *errorMsg;
    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        flag = YES;
        NSAssert(0, @"创建数据库表错误: %s", errorMsg);
    }else
    {
        flag = YES;
                NSLog(@"创建表成功");
        
        
    }
    
    return flag;
    
}

-(BOOL)createTableWithName:(NSString *)tableName andModel:(id)model{
//    NSString *str=@"CREATE TABLE IF NOT EXISTS loginInfo (id INTEGER PRIMARY KEY,userName text,password text,email text,nickName text,city text)";
    _tableName=tableName;
    NSString *baseStr=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY",tableName];
    NSArray *allPropertys=[[self getAllOfPropertysAndPropertyValueWithModel:model] allKeys];
    for (NSString *str in allPropertys) {
       baseStr=[baseStr stringByAppendingString:[NSString stringWithFormat:@",%@ text",str]];
        
    }
    baseStr=[baseStr stringByAppendingString:@")"];
    YANGLog(@"--------%@------%@---",baseStr,model);
    BOOL flag;
    //创建数据库表
    NSString *createSQL = baseStr;
    char *errorMsg;
    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        flag = YES;
        NSAssert(0, @"创建数据库表错误: %s", errorMsg);
    }else
    {
        flag = YES;
        NSLog(@"创建表成功");
    }
    return flag;
}
-(BOOL)InserDatasourceWithModel:(id)model{
    NSArray *allValues=[[self getAllOfPropertysAndPropertyValueWithModel:model] allValues];
    NSArray *allKeys=[[self getAllOfPropertysAndPropertyValueWithModel:model] allKeys];
    _allKeys=(NSMutableArray *)allKeys;
    NSString *baseStr=[NSString stringWithFormat:@"INSERT INTO %@ (",_tableName];
    
    for (NSString *str in allKeys) {
       baseStr= [baseStr stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@,",str]];
    }
    baseStr=[baseStr substringWithRange:NSMakeRange(0, baseStr.length-1)];
    baseStr=[baseStr stringByAppendingString:@") VALUES ("];
    for (NSString *str in allValues) {
        baseStr= [baseStr stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"'%@',",str]];
    }
    baseStr=[baseStr substringWithRange:NSMakeRange(0, baseStr.length-1)];
    baseStr=[baseStr stringByAppendingString:@")"];
    BOOL flag;
    const char *insert_stmt = [baseStr UTF8String];
    if (sqlite3_prepare_v2(database, insert_stmt,-1, &stmt, NULL) == SQLITE_OK)
    {
        NSLog(@"语法正确");
        flag = YES;
    }
    else
    {
        NSLog(@"语法错误！！！");
        flag = NO;
    }
    
    if (sqlite3_step(stmt) != SQLITE_DONE)
    {
        NSLog(@"插入失败");
        flag = NO;
    }
    else
    {
        NSLog(@"插入成功");
        flag = YES;
    }
    sqlite3_reset(stmt);
    return flag;
}
- (BOOL)InserSQL:(NSString *)Sqlstr datasource:(NSArray <NSString *> *)array
{
    
    BOOL flag;
    const char *insert_stmt = [Sqlstr UTF8String];
    
    if (sqlite3_prepare_v2(database, insert_stmt,-1, &stmt, NULL) == SQLITE_OK)
    {
                NSLog(@"语法正确");
        for (int i = 0; i < array.count; i ++) {
            
            NSString * sql = array[i];
            sqlite3_bind_text(stmt, i + 1,sql.UTF8String , -1, NULL);
            
        }
        flag = YES;
        
    }
    else
    {
        NSLog(@"语法错误！！！");
        flag = NO;
    }
    
    if (sqlite3_step(stmt) != SQLITE_DONE)
    {
        NSLog(@"插入失败");
        flag = NO;
    }
    else
    {
                NSLog(@"插入成功");
        flag = YES;
    }
    
    sqlite3_reset(stmt);
    return flag;
    
}

- (BOOL)deleteDB:(NSString *)Sqlstr
{
    BOOL flag;
    
    NSString *sql = Sqlstr;
    int result =  sqlite3_exec(database, sql.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        //        NSLog(@"删除成功");
        flag = YES;
    }
    else
    {
        NSLog(@"删除失败");
        flag = NO;
    }
    
    return flag;
}

- (BOOL)updateDB:(NSString *)Sqlstr
{
    BOOL flag;
    NSString *sql = Sqlstr;
    int result =  sqlite3_exec(database, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
                NSLog(@"修改成功");
        flag = YES;
    }
    else
    {
        NSLog(@"修改失败");
        flag = NO;
    }
    return flag;
}

- (NSArray *)selectDB:(NSString *)Sqlstr
{
    NSMutableArray * DBdatasource = [NSMutableArray new];
    NSString *sql = Sqlstr;
    if (sqlite3_prepare_v2(database, sql.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        //获得行数
        int totalColumns = sqlite3_column_count(stmt);
        int i = 0;
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //获得数据
            NSArray *keyArr=@[@"id",@"userName",@"password",@"email",@"nickName",@"city"];
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            for (int j = 0; j <totalColumns ;j ++) {
                char *rowData = (char *)sqlite3_column_text(stmt, j);
                [dict setObject:[NSString stringWithUTF8String:rowData] forKey:keyArr[j]];
            }
            [DBdatasource addObject:dict];
            i ++;
        }
        sqlite3_finalize(stmt);
    }
    
    return DBdatasource;
}

- (NSArray *)selectSQLiteWithKeyWord:(NSString *)keyWord andValue:(NSString *)value{
    NSMutableArray * DBdatasource = [NSMutableArray new];
    NSString *sql ;
    if (keyWord.length==0||value.length==0) {
       sql  = [NSString stringWithFormat:@"select * from %@ ",_tableName];
    }else{
       sql  = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",_tableName,keyWord,value];
    }
    if (sqlite3_prepare_v2(database, sql.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        //获得行数
        int totalColumns = sqlite3_column_count(stmt);
        int i = 0;
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //获得数据
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            for (int j = 1; j <totalColumns ;j ++) {
                char *rowData = (char *)sqlite3_column_text(stmt, j);
                [dict setObject:[NSString stringWithUTF8String:rowData] forKey:_allKeys[j-1]];
            }
            [DBdatasource addObject:dict];
            i ++;
        }
        sqlite3_finalize(stmt);
    }
    return DBdatasource;
}
-(NSDictionary *)getAllOfPropertysAndPropertyValueWithModel:(id)model{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([model class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        id value=[model valueForKey:ivarName];
        [dict setObject:value forKey:ivarName];
    }
    free(ivarList);
    return dict;
}
@end
