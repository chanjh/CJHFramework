//
//  CJHBaseVC.h
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/9.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSUInteger, CJHNavBarItemType) {
    CJHNavBarItemLeft,
    CJHNavBarItemRight,
};
@interface CJHBaseVC : UIViewController

/*
 * 展示时间
 * 用于设置 HUD 等展示时间
 */
@property (assign, nonatomic) NSInteger showTime;

@property (nonatomic, strong) UIButton *leftNavBarItem;
@property (nonatomic, strong) UIButton *rightNavBarItem;
/*
 * 对象实例化
 * 用于设置 tarBar 的 vc
 */
-(instancetype)initAsBaseVCWithNumber:(NSUInteger)number;

/*
 * 自定义 navBarItems
 */
- (void)customNavBarItemWithImage:(NSString *)normalName
                         highligh:(NSString *)highlighName
                            title:(NSString *)title
                             type:(CJHNavBarItemType)type
                           action:(dispatch_block_t)btnBlock;

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
-(void)hideHudLatterWithTime:(NSInteger)time;
-(void)hideHud;


-(void)showHudAndHideLatterWithCue:(NSString *)cue;

// 当使用 pop 的时候，可以使用本方法在上一个 VC 里显示 HUD
-(void)showHudInLastVCAndHideLatterWithCue:(NSString *)cue;

@end
