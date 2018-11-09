//
//  YYHttpRequest.h
//  AeroIP_SOW
//
//  Created by YY on 2017/1/5.
//  Copyright © 2017年 yosemite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -11,
    NetworkReachabilityStatusNotReachable     = 10,
    NetworkReachabilityStatusReachableViaWWAN = 11,
    NetworkReachabilityStatusReachableViaWiFi = 12,
};
typedef void(^HttpRequestCache)(id responseCache);
@interface YYHttpRequest : NSObject

//  POST请求
+ (void)POST:(NSString *)URLString parameters:(id)parameters progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(NSDictionary *responseObject))success failure:(void (^)(NSError * error))failure;

+ (void)GET:(NSString *)URLString parameters:(NSDictionary*)parameters HttpRequestCache:(HttpRequestCache) responseObjectCache success:(void(^)(NSDictionary *responseObject))success failure:(void (^)(NSError * error))failure;

//  下载文件到某个路径下
+ (void)downloadWithURL:(NSString *)URL fileDir:(NSString *)fileDir progress:(void(^)(NSProgress *downloadProgrss))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *erro))failure;


//  上传图片
+(void)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters image:(UIImage*)image name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *erro))failure;


+(void)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *erro))failure;


+ (void)setNetworkStatusChangeBlock:(void (^)(NetworkReachabilityStatus status))block;
@end
