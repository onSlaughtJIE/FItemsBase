//
//  AppDelegate.m
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "AppDelegate.h"
#import "QKTabBarController.h"
#import "LoginViewController.h"
#import "GuideViewController.h"
#import "QKNavigationController.h"



@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
//
//    QKTabBarController *tabBarVC = [[QKTabBarController alloc] init];
//    self.window.rootViewController = tabBarVC;
//
    
    [WXApi registerApp:@"wx6256287a112acde9" withDescription:@"weixin"];
    [self configurationIQKeyboard];
     [self setupIntroductoryPage];

    return YES;
}

-(void)setupIntroductoryPage{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = FUserDefaultObjectForKey(@"FAppVersion");
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        FUserDefaultSetObjectForKey(currentAppVersion, @"FAppVersion");
        GuideViewController *guideVC = [GuideViewController new];
        FWeakSelf(self)
        guideVC.guideBtnBlock = ^() {
            [weakself loginIn];
        };
        self.window.rootViewController = guideVC;
    }else{
        [self loginIn];
    }
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
}
#pragma mark - 登录
-(void)loginIn{

    if ([FUserDefaultObjectForKey(@"account") isEqualToString:@""] || FUserDefaultObjectForKey(@"account") == nil ||[FUserDefaultObjectForKey(@"passWord") isEqualToString:@""] ||FUserDefaultObjectForKey(@"passWord") == nil) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        QKNavigationController *qkNav = [[QKNavigationController alloc]initWithRootViewController:loginVC];
        
        self.window.rootViewController = qkNav;
        [self.window makeKeyAndVisible];
    }
    
    if (FUserDefaultObjectForKey(@"passWord") != nil && FUserDefaultObjectForKey(@"account") != nil) {
            QKTabBarController *tabBarVC = [[QKTabBarController alloc] init];
            self.window.rootViewController = tabBarVC;
    }

}



//处理微信通过URL启动时传递的数据

//前面的两个方法被iOS9弃用了，如果是Xcode7.2网上的话会出现无法进入进入微信的onResp回调方法，就是这个原因。
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
   
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];

}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        return YES;
    }
    
    //    这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}




#pragma mark - 配置IQKeyboardManager
- (void)configurationIQKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
