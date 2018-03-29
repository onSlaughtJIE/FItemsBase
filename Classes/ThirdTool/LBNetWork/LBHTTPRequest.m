//
//  LBHTTPRequest.m
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "LBHTTPRequest.h"


@implementation LBHTTPRequest

#pragma mark - 登录接口
+ (void)getLoginWithParameter:(NSDictionary *)parameter resultBlock:(resultBlock)resultBlock{
//    [MBProgressHUD showMessage:@"正在登录"];
    NSString *urlString = @"";
    FLog(@"%@---%@",urlString,parameter);
    [LBNetWorkHelper GET:urlString parameters:parameter
    success:^(id responseObject) {
        resultBlock(responseObject,nil);
        FLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
}
+(void)getWechatParamsWithOIderId:(NSDictionary *)param resultBlock:(resultBlock)resultBlock {
    NSString *urlString = @"";
    [LBNetWorkHelper GET:urlString parameters:param success:^(id responseObject) {
        resultBlock(responseObject,nil);
        FLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
   
}

+(void)getPrepayIdWithParam:(NSDictionary *)param resultBlock:(resultBlock)resultBlock {
    NSString *urlString = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
    [LBNetWorkHelper GET:urlString parameters:param success:^(id responseObject) {
        resultBlock(responseObject,nil);
        FLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
}

#pragma mark - 判断用户是否登录
+ (BOOL)isLogin{
    if (FDictIsEmpty(FUserDefaultObjectForKey(@"userInfo"))) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 退出登录
+ (void)exitLogin{
    FUserDefaultRemoveObjectForKey(@"userInfo");
    FUserDefaultRemoveObjectForKey(@"password");
}

#pragma mark - 获取用户ID
+ (NSString *)getUserID{
    if (!FDictIsEmpty(FUserDefaultObjectForKey(@"userInfo"))) {
        return [FUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpID"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户名字
+ (NSString *)getUserName{
    if (!FDictIsEmpty(FUserDefaultObjectForKey(@"userInfo"))) {
        return [FUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpName"];
    }else{
        return @"";
    }
}
#pragma mark - 获取用户所在公司ID
+ (NSString *)getUserCompanyID {
    if (!FDictIsEmpty(FUserDefaultObjectForKey(@"userInfo"))) {
        return [FUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpCompany"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户所在单位
+ (NSString *)getUserModule{
    if (!FDictIsEmpty(FUserDefaultObjectForKey(@"userInfo"))) {
        return [FUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpModule"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户所在部门
+ (NSString *)getUserDep{
    if (!FDictIsEmpty(FUserDefaultObjectForKey(@"userInfo"))) {
        return [FUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpDep"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户工作
+ (NSString *)getUserJob{
    if (!FDictIsEmpty(FUserDefaultObjectForKey(@"userInfo"))) {
        return [FUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpJob"];
    }else{
        return @"";
    }
}


@end
