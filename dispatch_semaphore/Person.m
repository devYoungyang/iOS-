//
//  Person.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "Person.h"
@interface Person ()

@property (nonatomic,assign)float weight;

@end
@implementation Person

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.name= [aDecoder decodeObjectForKey:@"name"];
        self.sex=  [aDecoder decodeBoolForKey:@"sex"];
        self.height=   [aDecoder decodeDoubleForKey:@"height"];
        self.age= [aDecoder decodeIntForKey:@"age"];
        
//        unsigned int outCount;
//        Ivar * ivars = class_copyIvarList([self class], &outCount);
//        for (int i = 0; i < outCount; i ++) {
//            Ivar ivar = ivars[i];
//            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
//            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
//        }
    
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeBool:self.sex forKey:@"sex"];
    [aCoder encodeFloat:self.height forKey:@"height"];
//    unsigned int outCount;
//    Ivar * ivars = class_copyIvarList([self class], &outCount);
//    for (int i = 0; i < outCount; i ++) {
//        Ivar ivar = ivars[i];
//        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        [aCoder encodeObject:[self valueForKey:key] forKey:key];
//    }
}
-(float)weight{
    return 121.5;
}

-(void)setAge:(NSInteger)age{
     NSLog(@"setAge:");
    _age=age;
}
-(void)willChangeValueForKey:(NSString *)key{
    NSLog(@"willChangeValueForKey: - begin");
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey: - end");
}
-(void)didChangeValueForKey:(NSString *)key{
    NSLog(@"didChangeValueForKey: - begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey: - end");
}
//重写description方法，方便直接打印对象
- (NSString *)description {
    return [NSString stringWithFormat:@"name=%@ age=%li height=%f sex=%i",self.name,(long)self.age,self.height,self.sex];
}

-(void)eat{
    NSLog(@"--%s--",__func__);
}
-(void)run{
    NSLog(@"--%s--",__func__);
}
-(void)playFootBall{
    NSLog(@"--%s--",__func__);
}

@end
