//
//  FBaseVController.h
//  FItemsBase
//
//  Created by 连杰 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

typedef NS_ENUM(NSInteger,positionStype) {
    PositionTop,
    PositionCenter,
    PositionBottom,
};

@interface FBaseVController : UIViewController
@property (nonatomic,strong) UIView *naviView;
@property (nonatomic,strong) UILabel *controllerTitleLable;
@property (nonatomic,strong) UIButton *popButton;
//loading的对象
@property (nonatomic,strong) MBProgressHUD *progressHUD;
/*
 *显示loading
 */
-(void)showProgressHUD;
/*
 *显示带文字的loading
 */
-(void)showProgressHUDWithStr:(NSString *)str;

/*
 *隐藏loading
 */
-(void)hidenProgressHUD;

/*
 *只展示文字
 */
- (void)showOnleText:(NSString *)text delay:(NSTimeInterval)delay;
/*
 *封装显示弹出框的方法,过1秒自动消失
 */
- (void)showAlertControlerWithMessage:(NSString *)message delay:(NSTimeInterval)delay;
/*
 *显示位置
 */
- (void)showOnlyText:(NSString *)text delay:(NSTimeInterval)delay position:(positionStype)position;

- (void)supviewCusNavi;







@end
