//
//  CJHBaseVC.m
//  CJHFramework
//
//  Created by 陈嘉豪 on 2017/1/9.
//  Copyright © 2017年 陈嘉豪. All rights reserved.
//

#import "CJHBaseVC.h"

@interface CJHBaseVC ()

@property (nonatomic, strong) NSArray *iconNames;
@property (nonatomic, strong) NSArray *iconSelectedNames;
@property (nonatomic, strong) NSArray *navBarNames;
@property (nonatomic, strong) NSArray *tabBatNames;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation CJHBaseVC

-(instancetype)initWithNumber:(NSUInteger)number{
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

#pragma mark ****HUD****
-(void)showHudInLastVCAndHideLatterWithCue:(NSString *)cue{
    CJHBaseVC *vc = [self.navigationController.viewControllers firstObject];
    [vc showHudAndHideLatterWithCue:cue];
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
    [self.HUD hideAnimated:YES afterDelay:showTime];
    [self.HUD showAnimated:YES];
}

-(void)hideHudLatter{
    [self.HUD hideAnimated:YES afterDelay:showTime];
}
- (void)hideHud{
    [self.HUD hideAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
