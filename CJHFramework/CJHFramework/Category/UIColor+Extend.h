//
//  UIColor+Extend.h
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/16.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

#define menuItemColor RGB(231,231,231)
#define newsBackground RGB(236, 236, 236)
#define PGHighlightedColor [UIColor colorWithRed:54.0/255.0 green:71.0/255.0 blue:121.0/255.0 alpha:0.9]

@interface UIColor (hexColor)

+ (UIColor *)hexFloatColor:(NSString *)hexStr;

@end

