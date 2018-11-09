//
//  YYHttpRequest.m
//  AeroIP_SOW
//
//  Created by YY on 2017/1/5.
//  Copyright © 2017年 yosemite. All rights reserved.
//

#import "YYHttpRequest.h"
#import "AFNetworking.h"

@implementation YYHttpRequest

//  POST请求
+ (void)POST:(NSString *)URLString parameters:(id)parameters progress:(void(^)(NSProgress * uploadProgress))progress success:(void(^)(NSDictionary *responseObject))success failure:(void (^)(NSError * error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
     AFHTTPSessionManager*manager = [self createAFHTTPSessionManager];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        YANGLog(@"responseObject=%@",dict);
        success(dict);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        YANGLog(@"error=%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}
+(void)GET:(NSString *)URLString parameters:(NSDictionary*)parameters HttpRequestCache:(HttpRequestCache) responseObjectCache success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    [PPNetworkHelper setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerHTTP];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerHTTP];
    [PPNetworkHelper setSecurityPolicyWithCerPath:nil validatesDomainName:YES];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [PPNetworkHelper GET:URLString parameters:parameters responseCache:^(id responseCache) {
        if (responseCache) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseCache options:kNilOptions error:nil];
            //        YANGLog(@"responseCache=%@",dict);
            responseObjectCache(dict);
        }
    } success:^(id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        YANGLog(@"responseObject=%@",dict);
        success(dict);
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSError *error) {
        failure(error);
        YANGLog(@"error=%@",error);
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    AFHTTPSessionManager*manager = [self createAFHTTPSessionManager];
//    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        YANGLog(@"responseObject=%@",dict);
//        success(dict);
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//        YANGLog(@"error=%@",error);
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    }];
}
//  下载文件到某个路径下
+(void)downloadWithURL:(NSString *)URL fileDir:(NSString *)fileDir progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *manager=[self createAFHTTPSessionManager];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}


//  上传图片
+(void)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters image:(UIImage*)image name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *erro))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *manager=[self createAFHTTPSessionManager];

    [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}
+(void)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failure:(void(^)(NSError *erro))failure
{
    AFHTTPSessionManager *manager=[self createAFHTTPSessionManager];
  
    [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+(void)setNetworkStatusChangeBlock:(void (^)(NetworkReachabilityStatus))block{
    AFNetworkReachabilityManager *manager=[AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                block(-11);
                break;
            case 0:
                block(10);
                break;
            case 1:
                block(11);
                break;
            case 2:
                block(12);
                break;
                
            default:
                break;
        }
    }];
}
+ (AFHTTPSessionManager *)createAFHTTPSessionManager
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    return manager;
}


@end
