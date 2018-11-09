//
//  GCDHelper.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "GCDHelper.h"

@implementation GCDHelper

+(void)gcdAsyncWithConcurrentCallBack:(void (^)(void))callBack andBackMainQueue:(void (^)(void))mainCallBack{
    dispatch_queue_t queue=dispatch_queue_create("const char * _Nullable label", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        callBack();
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        mainCallBack();
    });
}
@end
