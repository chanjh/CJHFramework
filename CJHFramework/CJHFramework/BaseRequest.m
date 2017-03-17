//
//  BaseRequest.m
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/25.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest


-(instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+ (NSString *)webImageURL {
    return BASE_URL;
}

+ (NSString *)documentURL {
    
    return BASE_URL;
}

+ (NSString *)articleURL {
    
    return BASE_URL;
}

- (void)clearCompletionBlock {
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (CJHRequestMethod)requestMethod{
    
    return CJHRequestMethodGet;
}

-(NSString *)baseURL{
    
    return @"";
}

// 请求的URL
- (NSString *)requestUrl{
    return @"";
}

// 请求的参数列表
- (id)requestArgument{
    return nil;
}


- (BOOL)validResponseObject:(id)responseObject{
    if (!responseObject) {
        return NO;
    }
    
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        
        return NO;
    }
    
    if(![responseObject[@"success"] boolValue]){
        
        return NO;
    }
    
    return YES;
}

- (CJHRequestSerializerType)requestSerializerType {
    return CJHRequestSerializerTypeHTTP;
}

- (void)startWithCompletionBlockWith:(SuccessCompletionBlock)successCompletionBlock
                             failure:(FailureCompletionBlock)failureCompletionBlock{
    
    self.successCompletionBlock = successCompletionBlock;
    self.failureCompletionBlock = failureCompletionBlock;
    
    if (![self checkNetworkConnection]) {
        self.failureCompletionBlock(self);
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            // 没有网络
        });
        return;
    }
    
    CJHRequestMethod method = [self requestMethod]; //枚举
    NSString *url = [self buildRequestUrl];
    if([url isEqualToString:@""]){
        return;
    }
    _manager = [AFHTTPSessionManager manager];
    _manager.operationQueue.maxConcurrentOperationCount = 5;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain",nil];
    //serializer 串行器
    
    id param = [self requestArgument];
    if(self.requestMethod == CJHRequestMethodPost){
        //
    }
    
    
    NSLog(@"请求的URL是:%@\n,参数是:%@",url,param);
    
    if ([self requestSerializerType] == CJHRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if ([self requestSerializerType] == CJHRequestSerializerTypeJSON) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    _manager.requestSerializer.timeoutInterval = [self timeoutInterval];
    
    switch (method) {
        case CJHRequestMethodGet:   //获得数据
        {
            [_manager  GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                successCompletionBlock(self, responseObject);
                NSLog(@"返回数据是:%@\n",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failureCompletionBlock(self);
                NSLog(@"访问出错了Error:%@",[error description]);
            }];
            
        }
            break;
        case CJHRequestMethodPost:      //发送数据
        {
            [_manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSArray *allObjs = [param allValues];
                NSArray *allKeys = [param allKeys];
                [allObjs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if([obj isKindOfClass:[NSData class]]){
                        [formData appendPartWithFileData:obj name:allKeys[idx] fileName:allKeys[idx] mimeType:@"image/jpeg"];
                    }
                }];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                NSLog(@"---上传进度--- %@",uploadProgress);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"```上传成功``` %@",responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"xxx上传失败xxx %@", error);
                
            }];
            
        }
            break;
        default:
            break;
    }
    
}

-(NSInteger)timeoutInterval{
    return 30;
}

- (NSString *)buildRequestUrl{
    
    NSString *requestURL = @"";
    if([[self requestUrl] isEqualToString:@""]){
        requestURL = @"";
    }
    else if ([[self baseURL] isEqualToString:@""]) {
        
        requestURL = [BASE_URL stringByAppendingString:
                      [NSString stringWithFormat:@"%@",[self requestUrl]]];
    }
    else
    {
        requestURL = [[self baseURL] stringByAppendingString:[self requestUrl]];
    }
    
    return requestURL;
}



- (BOOL)checkNetworkConnection{
    
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
