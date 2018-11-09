//
//  YYSQLiteManager.h

//
//  Created by YY on 2017/6/22.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSQLiteManager : NSObject
+ (instancetype )shareBaseDB;
/**
 *  创建一个数据库目录包含.db或.sqlite3结束
 *
 *  @param DBPath 数据库储存路径，一般是用（参考） NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 self.documentsDirectory = [paths objectAtIndex:0];
 *
 *  @return Bool
 */
- (BOOL)createDB:(NSString *)DBPath;

-(void)createSQLiteName:(NSString *)name;

/**
 *  使用SQL语句自创建一个数据库表
 *
 *  @param Sqlstr SQL语句字符串
 *
 *  @return BOOL
 */
- (BOOL)createTable:(NSString *)Sqlstr;


-(BOOL)createTableWithName:(NSString *)tableName andModel:(id)model;

/**
 *  使用SQL语句插入数据
 *
 *  @param Sqlstr SQL语句字符串
 *  @param array  以字符串形式传入数据
 *
 *  @return Bool
 */

- (BOOL)InserSQL:(NSString *)Sqlstr datasource:(NSArray <NSString *> *)array;


-(BOOL)InserDatasourceWithModel:(id)model;
/**
 *  使用SQL语句删除数据
 *
 *  @param Sqlstr SQL语句字符串
 *
 *  @return BOOL
 */
- (BOOL)deleteDB:(NSString *)Sqlstr;
/**
 *  使用SQL语句修改数据
 *
 *  @param Sqlstr SQL语句字符串
 *
 *  @return BOOL
 */
- (BOOL)updateDB:(NSString *)Sqlstr;
/**
 *  使用SQL语句遍历数据
 *
 *  @param Sqlstr SQL语句字符串
 *
 *  @return BOOl
 */

- (NSArray *)selectDB:(NSString *)Sqlstr;

- (NSArray *)selectSQLiteWithKeyWord:(NSString *)keyWord andValue:(NSString *)value;
@end
