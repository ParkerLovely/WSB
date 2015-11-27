//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HM)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view color:(UIColor *)color;
+ (void)showError:(NSString *)error toView:(UIView *)view color:(UIColor *)color;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view color:(UIColor *)color;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message color:(UIColor *)color;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;



@end
