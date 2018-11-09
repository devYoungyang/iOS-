//
//  Person.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,copy)NSString *name;

@property (nonatomic,assign)NSInteger age;

@property (nonatomic,assign)BOOL sex;

@property (nonatomic,assign)float height;


@end
