//
//  ResetPWVController.m
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "ResetPWVController.h"
#import "commenTField.h"
#import "UIButton+countDown.h"


@interface ResetPWVController ()
@property (nonatomic,strong) commenTField *userNTFd;
@property (nonatomic,strong) commenTField *phoneNTFd;
@property (nonatomic,strong) commenTField *verCodeTFd;
@property (nonatomic,strong) commenTField *passWTFd;
@property (nonatomic,strong) commenTField *affirmPWTFd;
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UIButton *sendMBtn;

@end

@implementation ResetPWVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];

    [self addsubViews];
    [self containsView];
}

-(void)addsubViews{
    //输入用户名
    _userNTFd = [[commenTField alloc]init];
    [_userNTFd setImgName:@"YH1.png" andPlaceHString:@"请输入您的用户名" andSecureEntry:NO];

    
    [self.view addSubview:_userNTFd];
    
    
    //输入手机号
    _phoneNTFd = [[commenTField alloc]init];
    [_phoneNTFd setImgName:@"phone.png" andPlaceHString:@"请输入您的手机号" andSecureEntry:NO];
    _phoneNTFd.keyboardType = UIKeyboardTypeNumberPad;
    
    
    [self.view addSubview:_phoneNTFd];
    
    //验证码
    _verCodeTFd = [[commenTField alloc]init];
    [_verCodeTFd setImgName:@"code.png" andPlaceHString:@"请输入验证码" andSecureEntry:NO];
    _verCodeTFd.keyboardType = UIKeyboardTypeNumberPad;
    
    //添加获取验证码按钮
    _sendMBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,(FScreenWidth-60)/5*2 , 40)];
    _sendMBtn.backgroundColor = [UIColor orangeColor];
    _sendMBtn.layer.cornerRadius = 6;
    [_sendMBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendMBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendMBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _verCodeTFd.rightViewMode = UITextFieldViewModeAlways;
    _verCodeTFd.rightView = _sendMBtn;
    [_sendMBtn addTarget:self action:@selector(timeCountDown:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.view addSubview:_verCodeTFd];
    
    //登陆密码
    _passWTFd = [[commenTField alloc]init];
    [_passWTFd setImgName:@"mima.png" andPlaceHString:@"请设置新的登陆密码" andSecureEntry:YES];
    
    [self.view addSubview:_passWTFd];
    
    //确认密码
    _affirmPWTFd = [[commenTField alloc]init];
    [_affirmPWTFd setImgName:@"mima.png" andPlaceHString:@"请确认登陆密码" andSecureEntry:YES];
    
    [self.view addSubview:_affirmPWTFd];
    
    //确定按钮
    _confirmBtn = [[UIButton alloc]init];
    _confirmBtn.backgroundColor = FRGB(142.0, 82.0, 253.0);
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = 6;
    [_confirmBtn addTarget: self action:@selector(regiResult) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_confirmBtn];
  

    
    
    
    
}

-(void)containsView{
    FWeakSelf(self);
    
    [weakself.userNTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view).with.offset(50);
        make.left.equalTo(weakself.view).with.offset(30);
//        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
    [weakself.phoneNTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.userNTFd.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
//        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
    [weakself.verCodeTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.phoneNTFd.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
    [weakself.passWTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.verCodeTFd.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
    [weakself.affirmPWTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWTFd.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
    [weakself.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.affirmPWTFd.mas_bottom).with.offset(40);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
  
}


#pragma mark - 确认按钮（判断信息是否正确）
-(void)regiResult{
    if (_userNTFd.text.length == 0||_phoneNTFd.text.length == 0||_verCodeTFd.text.length == 0||_passWTFd.text.length == 0||_affirmPWTFd.text.length == 0) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"必填项不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -封装异步倒计时
-(void)timeCountDown:(UIButton *)btn{
    //判断手机号的正确性
    if (_phoneNTFd.text.length == 0) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"手机号不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        return;
    }
    
    if (_phoneNTFd.text.length != 11)
        
    {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        return;
        
    }
    
    /**
     
     * 手机号码:
     
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     
     * 电信号段: 133,149,153,170,173,177,180,181,189
     
     */
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    
    /**
     
     * 中国移动：China Mobile
     
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     
     */
    
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    
    /**
     
     * 中国联通：China Unicom
     
     * 130,131,132,145,155,156,170,171,175,176,185,186
     
     */
    
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|6[6]|7[0156]|8[56])\\d{8}$";
    
    /**
     
     * 中国电信：China Telecom
     
     * 133,149,153,170,173,177,180,181,189
     
     */
    
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    
    
    if (([regextestmobile evaluateWithObject:_phoneNTFd.text] == YES)
        
        || ([regextestcm evaluateWithObject:_phoneNTFd.text] == YES)
        
        || ([regextestct evaluateWithObject:_phoneNTFd.text] == YES)
        
        || ([regextestcu evaluateWithObject:_phoneNTFd.text] == YES))
        
    {
        
        [_sendMBtn startWithTime:59 title:@"获取验证码" countDownTitle:@"s后重试" mainColor:[UIColor orangeColor] countColor:[UIColor grayColor]];
        
    }
    
    else
        
    {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        return;
        
    }
    
    
    
    
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
