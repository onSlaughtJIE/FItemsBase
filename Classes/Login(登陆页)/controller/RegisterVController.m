//
//  RegisterVController.m
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "RegisterVController.h"
#import "Masonry.h"
#import "UIButton+countDown.h"
//#import "WebDitleViewController.h"


@interface RegisterVController ()
@property (nonatomic,strong) commenTField *referrerTFd;
@property (nonatomic,strong) commenTField *assitTFd;
@property (nonatomic,strong) commenTField *phoneNTFd;
@property (nonatomic,strong) commenTField *verCodeTFd;
@property (nonatomic,strong) commenTField *passWTFd;
@property (nonatomic,strong) commenTField *affirmPWTFd;


@property (nonatomic,strong) UIView *marketView;
@property (nonatomic,strong) UIButton *firGroBtn;
@property (nonatomic,strong) UIButton *secGroBtn;


@property (nonatomic,strong) UIButton *delegBtn;
@property (nonatomic,strong) UIButton *affdeleBtn;
@property (nonatomic,strong) UIButton *regiBtn;

@property (nonatomic,strong) UIButton *Findbtn;
@property (nonatomic,strong) UIButton *FindAssbtn;
@property (nonatomic,strong) UIButton *sendMBtn;
@property (nonatomic,strong) NSTimer *leveTimer;
@property (nonatomic,assign) int totleTime;

@end

@implementation RegisterVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];

    _totleTime = 59;
    
    [self addsubViews];
    [self addConstains];
    
    if (IS_IPHONE_5) {
        _referrerTFd.font = [UIFont systemFontOfSize:13.0];
        _assitTFd.font = [UIFont systemFontOfSize:13.0];
    }
}

#pragma mark - 添加子视图
-(void)addsubViews{
//推荐人账号
    _referrerTFd = [[commenTField alloc]init];
    [_referrerTFd setImgName:@"referr.png" andPlaceHString:@"请输入推荐人账号" andSecureEntry:NO];
    
   
    //推荐人及帮扶人右按钮
    _Findbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,(FScreenWidth-60)/5*2 , 40)];
    _Findbtn.backgroundColor = FRGB(243.0, 234.0, 255.0);
    _referrerTFd.rightViewMode = UITextFieldViewModeAlways;
    _referrerTFd.rightView = _Findbtn;
    _Findbtn.layer.cornerRadius = 6;
    _Findbtn.layer.borderWidth = 0.3;
    _Findbtn.tag = 1;
    [_Findbtn addTarget:self action:@selector(findTureName:) forControlEvents:UIControlEventTouchUpInside];
    [_Findbtn setTitleColor:FRGB(142.0, 82.0, 253.0) forState:UIControlStateNormal];
    [_Findbtn setTitle:@"点击查询真实姓名" forState:UIControlStateNormal];
    _Findbtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_referrerTFd];
//帮扶人账号
    _assitTFd = [[commenTField alloc]init];
    [_assitTFd setImgName:@"assit.png" andPlaceHString:@"请输入帮扶人账号" andSecureEntry:NO];
    _FindAssbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,(FScreenWidth-60)/5*2 , 40)];
    _FindAssbtn.backgroundColor = FRGB(243.0, 234.0, 255.0);
    _FindAssbtn.layer.cornerRadius = 6;
    _FindAssbtn.layer.borderWidth = 0.3;
    [_FindAssbtn setTitleColor:FRGB(142.0, 82.0, 253.0) forState:UIControlStateNormal];
    [_FindAssbtn setTitle:@"点击查询真实姓名" forState:UIControlStateNormal];
    _FindAssbtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _FindAssbtn.tag = 2;
    _assitTFd.rightViewMode = UITextFieldViewModeAlways;
    _assitTFd.rightView = _FindAssbtn;
    [_FindAssbtn addTarget:self action:@selector(findTureName:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_assitTFd];
//市场 销售一二部
    _marketView = [[UIView alloc]init];

    UILabel *marLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (FScreenWidth-80)/8, 20)];
    marLab.text = @"市场:";

    marLab.adjustsFontSizeToFitWidth = YES;
//选择部门按钮
    _firGroBtn = [[UIButton alloc]initWithFrame:CGRectMake((FScreenWidth-80)/8+5, 2, 15, 15)];
    [_firGroBtn setImage:[UIImage imageNamed:@"sele.png"] forState:UIControlStateNormal];
    _firGroBtn.tag = 2;
    [_firGroBtn addTarget:self action:@selector(chooseGroup:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _secGroBtn = [[UIButton alloc]initWithFrame:CGRectMake((FScreenWidth-60)/2+15, 2, 15, 15)];
    [_secGroBtn setImage:[UIImage imageNamed:@"nonsele.png"] forState:UIControlStateNormal];
    _secGroBtn.tag = 1;
    [_secGroBtn addTarget:self action:@selector(chooseGroup:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *firL = [[UILabel alloc]initWithFrame:CGRectMake((FScreenWidth-80)/8+30, 0, (FScreenWidth-100)/4, 20)];
    firL.text = @"销售一部";
    firL.font = [UIFont systemFontOfSize:13.0];
    UILabel *secL = [[UILabel alloc]initWithFrame:CGRectMake((FScreenWidth-60)/2 + 40, 0, (FScreenWidth-100)/4, 20)];
    secL.text = @"销售二部";
    secL.font = [UIFont systemFontOfSize:13.0];

    [_marketView addSubview:secL];
    [_marketView addSubview:_secGroBtn];
    [_marketView addSubview:firL];
    [_marketView addSubview:_firGroBtn];
    [_marketView addSubview:marLab];
    [self.view addSubview:_marketView];
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
//    _sendMBtn.layer.borderWidth = 0.3;
    [_sendMBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendMBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendMBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _verCodeTFd.rightViewMode = UITextFieldViewModeAlways;
    _verCodeTFd.rightView = _sendMBtn;
    [_sendMBtn addTarget:self action:@selector(timeCountDown:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self.view addSubview:_verCodeTFd];

//登陆密码
    _passWTFd = [[commenTField alloc]init];
    [_passWTFd setImgName:@"mima.png" andPlaceHString:@"请设置您的登陆密码" andSecureEntry:YES];
    
    [self.view addSubview:_passWTFd];

//确认密码
    _affirmPWTFd = [[commenTField alloc]init];
    [_affirmPWTFd setImgName:@"mima.png" andPlaceHString:@"请确认登陆密码" andSecureEntry:YES];
    
    [self.view addSubview:_affirmPWTFd];

//注册按钮
    _regiBtn = [[UIButton alloc]init];
    _regiBtn.backgroundColor = FRGB(142.0, 82.0, 253.0);
    [_regiBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_regiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_regiBtn setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _regiBtn.layer.cornerRadius = 6;
    [_regiBtn addTarget: self action:@selector(regiResult) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_regiBtn];
//用户协议
    _affdeleBtn = [[UIButton alloc]init];
    _delegBtn = [[UIButton alloc]init];
    
    [_affdeleBtn setImage:[UIImage imageNamed:@"remb-yes.png"] forState:UIControlStateNormal];
    _affdeleBtn.tag = 1;
    
    
    [_affdeleBtn addTarget:self action:@selector(agreeState:) forControlEvents:UIControlEventTouchUpInside];
    [_delegBtn setTitle:@"已阅读并同意《用户注册协议》" forState:UIControlStateNormal];
    [_delegBtn addTarget:self action:@selector(delegateDtile) forControlEvents:UIControlEventTouchUpInside];
    _delegBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_delegBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    //设置字体居左
    _delegBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:_delegBtn];
    [self.view addSubview:_affdeleBtn];
}




#pragma mark - 添加约束
-(void)addConstains{
    FWeakSelf(self);
    [weakself.referrerTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    [weakself.assitTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.referrerTFd.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
//市场部约束
    [weakself.marketView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.assitTFd.mas_bottom).with.offset(5);
        make.left.equalTo(weakself.view).with.offset(50);
        make.right.equalTo(weakself.view).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-100, 20));
        
    }];
    
    
    
    [weakself.phoneNTFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.assitTFd.mas_bottom).with.offset(50);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
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
    
    [weakself.regiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.affirmPWTFd.mas_bottom).with.offset(40);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
        
    }];
    
    if (IS_IPHONE_5) {
     
        [weakself.referrerTFd mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.view).with.offset(10);
            make.left.equalTo(weakself.view).with.offset(30);
            make.right.equalTo(weakself.view).with.offset(-30);
            make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
            
        }];
        
        
        [weakself.regiBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.affirmPWTFd.mas_bottom).with.offset(10);
            make.left.equalTo(weakself.view).with.offset(30);
            make.right.equalTo(weakself.view).with.offset(-30);
            make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
            
        }];
        
    }
    
    [weakself.affdeleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.regiBtn.mas_bottom).with.offset(10);
        make.left.equalTo(weakself.view).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    [weakself.delegBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.regiBtn.mas_bottom).with.offset(10);
        make.left.equalTo(weakself.affdeleBtn.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake((FScreenWidth-100), 20));
        
    }];
    
}


#pragma mark - 选择部门方法
-(void)chooseGroup:(UIButton *)btn{
    if (btn.tag == 1) {
         [_firGroBtn setImage:[UIImage imageNamed:@"nonsele.png"] forState:UIControlStateNormal];
         [_secGroBtn setImage:[UIImage imageNamed:@"sele.png"] forState:UIControlStateNormal];
        [self adjugeTextFiltAlert];
        
        return;
    }
    if (btn.tag == 2) {

        [_firGroBtn setImage:[UIImage imageNamed:@"sele.png"] forState:UIControlStateNormal];
        [_secGroBtn setImage:[UIImage imageNamed:@"nonsele.png"] forState:UIControlStateNormal];
        [self adjugeTextFiltAlert];

        return;
    }

    
}

#pragma mark - 判断真实姓名
-(void)findTureName:(UIButton *)btn{
    if (btn.tag == 1) {
        if (_referrerTFd.text.length == 0) {
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入查询推荐人的账号" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FLog(@"点击确认");
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
        }else{
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"未查询到该用户,请重试" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FLog(@"点击确认");
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
        }
        
    }
    if (btn.tag == 2) {
        if (_assitTFd.text.length == 0) {
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入查询推荐人的账号" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FLog(@"点击确认");
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
        }else{
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"未查询到该用户,请重试" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                FLog(@"点击确认");
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
        }
    }
    
}

#pragma mark - 判断帮扶人和推荐人
-(void)adjugeTextFiltAlert{
    if (_assitTFd.text.length == 0 || _referrerTFd.text.length == 0) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"推荐人和帮扶人不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];

        [self presentViewController:alertCon animated:YES completion:nil];
    }else{
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"推荐人或帮扶人不存在" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
       
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    
    
    
    
    
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

#pragma mark - 判断注册是否成功
-(void)regiResult{
    if (_referrerTFd.text.length == 0 ||_assitTFd.text.length == 0||_phoneNTFd.text.length == 0||_verCodeTFd.text.length == 0||_passWTFd.text.length == 0||_affirmPWTFd.text.length == 0) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"必填项不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 是否同意协议
-(void)agreeState:(UIButton *)btn{
    
    if (btn.tag == 2) {
        _affdeleBtn.tag --;
        [btn setImage:[UIImage imageNamed:@"remb-yes.png"] forState:UIControlStateNormal];
        _regiBtn.enabled = YES;
        _regiBtn.backgroundColor = FRGB(142.0, 82.0, 253.0);
        
        return;
    }
    if (btn.tag == 1) {
        _affdeleBtn.tag ++;
        [btn setImage:[UIImage imageNamed:@"remb-no.png"] forState:UIControlStateNormal];
        
        _regiBtn.enabled = NO;
        _regiBtn.backgroundColor = [UIColor grayColor];
        return;
    }
    
}


#pragma mark - 跳转协议的详情页
-(void)delegateDtile{
//    WebDitleViewController *deleWebVC = [[WebDitleViewController alloc]init];
//    deleWebVC.webString = @"";
//
//    [self.navigationController pushViewController:deleWebVC animated:YES];
//    FLog(@"跳转协议页");
}


#pragma mark - 发送短信后倒计时--主线程执行方法（已舍弃）
-(void)countDown:(UIButton *)btn{
  

    [btn setTitle:[NSString stringWithFormat:@"%is后重试",_totleTime] forState:UIControlStateDisabled];
    btn.enabled = NO;
    
    
    _leveTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(leftTime) userInfo:nil repeats:YES];
    
}

-(void)leftTime{
    
    _totleTime--;
     if (_totleTime == 0) {
      _sendMBtn.enabled = YES;
      [_sendMBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
      [_leveTimer invalidate];
         _totleTime = 59;
     }
    FLog(@"------timer------%i",_totleTime);
     [_sendMBtn setTitle:[NSString stringWithFormat:@"%is后重试",_totleTime] forState:UIControlStateDisabled];
    
    
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
