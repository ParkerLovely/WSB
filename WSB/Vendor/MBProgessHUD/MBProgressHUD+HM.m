//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+HM.h"

@implementation MBProgressHUD (HM)
#warning xx
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view color:(UIColor *)color
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    //color
    hud.color = color;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}
#warning xx
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view color:(UIColor *)color{
    [self show:error icon:@"error.png" view:view color:color];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view color:(UIColor *)color
{
    [self show:success icon:@"success.png" view:view color:color];
}

+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self showError:error toView:view color:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self showSuccess:success toView:view color:nil];
}

#pragma mark 显示一些信息

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view color:(UIColor *)color{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.color = color;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    return [self showMessage:message toView:view color:nil];
}



+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message color:(UIColor *)color
{
    return [self showMessage:message toView:nil color:color];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil color:nil];
}


+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
