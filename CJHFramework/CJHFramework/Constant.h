//
//  Constant.h
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/16.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#define iPhone640 [[UIScreen mainScreen] currentMode].size.width - 640 < 1e-6
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define LeadingSpace  [UIScreen mainScreen].bounds.size.width/20
#define TraidingSpace [UIScreen mainScreen].bounds.size.width/20
#define SpaceBetween [UIScreen mainScreen].bounds.size.width/50

#define DEBUG_HTTP 0

#define statusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define navigationHeight self.navigationController.navigationBar.frame.size.height

// 后台的基础链接
#define kBaseHost  @""
