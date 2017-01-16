//
//  CJHBaseVC.h
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/9.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CJHBaseVC : UIViewController

/*
 * 展示时间
 * 用于设置 UIAlertView 和 HUD 等展示时间
 */
@property (assign, nonatomic) NSInteger showTime;


/*
 * 对象实例化
 * 用于设置 tarBar 的 vc
 */
-(instancetype)initAsBaseVCWithNumber:(NSUInteger)number;

/*
 * Alert 视图
 */
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
           andCancelTitle:(NSString *)cancel;

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message
               andActions:(NSArray <UIAlertAction *> *)actions;

/*
 * HUD 视图
 */
-(void)showWaitHudWithCue:(NSString *)cue;
-(void)showHudWithCue:(NSString *)cue;
-(void)hideHudLatter;
-(void)hideHud;


-(void)showHudAndHideLatterWithCue:(NSString *)cue;

// 当使用 pop 的时候，可以使用本方法在上一个 VC 里显示 HUD
-(void)showHudInLastVCAndHideLatterWithCue:(NSString *)cue;

@end
