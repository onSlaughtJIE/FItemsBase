//
//  FBaseVController.m
//  FItemsBase
//
//  Created by 连杰 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "FBaseVController.h"

@interface FBaseVController ()

@end

@implementation FBaseVController
//懒加载
- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHUD];
        _progressHUD.bezelView.color = [UIColor blackColor];
        _progressHUD.contentColor = [UIColor whiteColor];
    }
    return _progressHUD;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//显示loading
- (void)showProgressHUD {
    [self showProgressHUDWithStr:nil];
}
//带文字的loading
- (void)showProgressHUDWithStr:(NSString *)str {
    if (str.length == 0) {
        self.progressHUD.label.text = nil;
    } else {
        self.progressHUD.label.text = str;
    }
    //显示loading方法
    [self.progressHUD showAnimated:YES];
}
//隐藏loading
- (void)hidenProgressHUD {
    if (self.progressHUD != nil) {
        [self.progressHUD hideAnimated:YES];
        [self.progressHUD removeFromSuperViewOnHide];
        self.progressHUD = nil;
    }
}
- (void)showOnleText:(NSString *)text delay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    // Move to bottm center.
    hud.center = self.view.center;
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:delay];
}

//  封装显示弹出框的方法,过1秒自动消失
- (void)showAlertControlerWithMessage:(NSString *)message delay:(NSTimeInterval)delay {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:^{
        //  过1秒后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        });
        
    }];
}
//显示位置
- (void)showOnlyText:(NSString *)text delay:(NSTimeInterval)delay position:(positionStype)position {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    // Move to bottm center.
    hud.center = self.view.center;
    if (position == PositionCenter){
        
    } else {
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        
    }
    [hud hideAnimated:YES afterDelay:delay];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
