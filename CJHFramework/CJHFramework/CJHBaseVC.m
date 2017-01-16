//
//  CJHBaseVC.m
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/9.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#import "CJHBaseVC.h"
#import <objc/runtime.h>

static char *btnClickAction;

@interface CJHBaseVC ()

@property (nonatomic, strong) NSArray *iconNames;
@property (nonatomic, strong) NSArray *iconSelectedNames;
@property (nonatomic, strong) NSArray *navBarNames;
@property (nonatomic, strong) NSArray *tabBatNames;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation CJHBaseVC

-(instancetype)init{
    self = [super init];
    self.showTime = 1.5;
    return self;
}

-(instancetype)initAsBaseVCWithNumber:(NSUInteger)number{
    self = [super init] ;
    if(self){
        self.iconNames = @[@"icon_home_tabbar", @"icon_Investment_tabbar",
                           @"icon_account_tabbar", @"icon_more_tabbar"];
        
        self.iconSelectedNames = @[@"icon_home_tabbar_selected", @"icon_Investment_tabbar_selected",
                                   @"icon_account_tabbar_selected", @"icon_more_tabbar_selected"];
        
        self.navBarNames = @[@"首页", @"投资", @"账户", @"发现"];
        self.tabBatNames = @[@"推荐", @"投资", @"账户", @"发现"];
        
        [self setTabBatItemWithNumber:number];
    }
    return self;
}

-(void)setTabBatItemWithNumber:(NSUInteger)number{
    self.tabBarItem.image  = [UIImage imageNamed:_iconNames[number]];
    self.tabBarItem.selectedImage = [UIImage imageNamed:_iconSelectedNames[number]];
    self.tabBarItem.title = _tabBatNames[number];
    self.navigationItem.title = _navBarNames[number];
}
// 自定义 navBarItems
-(void)customNavBarItemWithImage:(NSString *)normalName
                        highligh:(NSString *)highlighName
                           title:(NSString *)title
                            type:(CJHNavBarItemType)type
                          action:(dispatch_block_t)btnBlock{
    if (type == CJHNavBarItemLeft) {
        
        self.leftNavBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self customNavBarButton:self.leftNavBarItem normalImage:normalName highligh:highlighName title:title];
        objc_setAssociatedObject(self.leftNavBarItem, &btnClickAction, btnBlock, OBJC_ASSOCIATION_COPY);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavBarItem];
    } else {
        
        self.rightNavBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self customNavBarButton:self.rightNavBarItem normalImage:normalName highligh:highlighName title:title];
        objc_setAssociatedObject(self.rightNavBarItem, &btnClickAction, btnBlock, OBJC_ASSOCIATION_COPY);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBarItem];
    }
}
- (void)customNavBarButton:(UIButton *)button
               normalImage:(NSString *)normalName
                  highligh:(NSString *)highlighName
                     title:(NSString *)title {
    [button setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    if (highlighName) {
        [button setImage:[UIImage imageNamed:highlighName] forState:UIControlStateHighlighted];
    }
    if (title) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16.];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    [button addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)actionBtnClick:(UIButton *)button {
    dispatch_block_t buttonBlock = objc_getAssociatedObject(button, &btnClickAction);
    if (buttonBlock) {
        buttonBlock();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0f green:148/255.0f blue:252/255.0f alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    self.HUD.removeFromSuperViewOnHide = YES;
}
#pragma mark ****Alert****
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message andCancelTitle:(NSString *)cancel{
    UIAlertController  *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message andActions:(NSArray <UIAlertAction *> *)actions{
    UIAlertController  *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSInteger i = 0; i < actions.count; i++){
        [controller addAction:actions[i]];
    }
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark ****HUD****
-(void)showHudInLastVCAndHideLatterWithCue:(NSString *)cue{
    CJHBaseVC *vc = [self.navigationController.viewControllers firstObject];
    [vc showHudAndHideLatterWithCue:cue];
    // TODO
    // 如果该 vc 不是基于 baseVC 的处理
}
-(void)showHudWithCue:(NSString *)cue{
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.label.text = cue;
    [self.view addSubview:self.HUD];
    [self.HUD showAnimated:YES];
}
-(void)showWaitHudWithCue:(NSString *)cue{
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.label.text = cue;
    [self.view addSubview:self.HUD];
    [self.HUD showAnimated:YES];
}
-(void)showHudAndHideLatterWithCue:(NSString *)cue{
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.label.text = cue;
    [self.view addSubview:self.HUD];
    [self.HUD hideAnimated:YES afterDelay:self.showTime];
    [self.HUD showAnimated:YES];
}
-(void)hideHudLatter{
    [self.HUD hideAnimated:YES afterDelay:self.showTime];
}
-(void)hideHudLatterWithTime:(NSInteger)time{
    [self.HUD hideAnimated:YES afterDelay:time];
}
- (void)hideHud{
    [self.HUD hideAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
