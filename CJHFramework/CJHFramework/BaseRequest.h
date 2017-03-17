//
//  BaseRequest.h
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/25.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define BASE_URL  @""

typedef NS_ENUM(NSInteger , CJHRequestMethod) {
    CJHRequestMethodGet = 0,
    CJHRequestMethodPost,
    CJHRequestMethodHead,
    CJHRequestMethodPut,
    CJHRequestMethodDelete,
};

typedef NS_ENUM(NSInteger , CJHRequestSerializerType) {
    CJHRequestSerializerTypeHTTP = 0,
    CJHRequestSerializerTypeJSON,
};
@interface BaseRequest : NSObject

typedef void(^SuccessCompletionBlock)(BaseRequest *baseRequest ,id responseObject);
typedef void(^FailureCompletionBlock)(BaseRequest *baseRequest);

@property (nonatomic,copy)SuccessCompletionBlock successCompletionBlock;
@property (nonatomic,copy)FailureCompletionBlock failureCompletionBlock;
@property (nonatomic, strong)AFHTTPSessionManager *manager;

- (void)startWithCompletionBlockWith:(SuccessCompletionBlock)successCompletionBlock
                             failure:(FailureCompletionBlock)failureCompletionBlock;



- (void)clearCompletionBlock;

// 覆盖实现这些方法
// Http请求的方法
- (CJHRequestMethod)requestMethod;
- (CJHRequestSerializerType)requestSerializerType;

-(NSString *)baseURL;
// 请求的URL
- (NSString *)requestUrl;

// 请求的参数列表
- (id)requestArgument;

- (BOOL)validResponseObject:(id)responseObject;

+ (NSString *)webImageURL;
+ (NSString *)documentURL;
+ (NSString *)articleURL;
-(BOOL)checkNetworkConnection;

-(NSInteger)timeoutInterval;@end
