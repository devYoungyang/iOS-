//
//  GCDHelper.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDHelper : NSObject

+(void)gcdAsyncWithConcurrentCallBack:(void (^)(void)) callBack andBackMainQueue:(void (^)(void)) mainCallBack;


@end
