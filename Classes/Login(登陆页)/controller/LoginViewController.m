//
//  LoginViewController.m
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "MD5+NSString.h"
#import "RegisterVController.h"
#import "ResetPWVController.h"
#import "AppDelegate.h"

@interface LoginViewController ()<MBProgressHUDDelegate>

@property (nonatomic,strong) commenTField *txtNumberF;
@property (nonatomic,strong) commenTField *passWdF;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UILabel *remTipLab;
@property (nonatomic,strong) UILabel *titLable;
@property (nonatomic,strong) UIImageView *zicImg;
@property (nonatomic,strong) UIButton *rembPswBtn;
@property (nonatomic,strong) UIButton *forgPswBtn;
@property (nonatomic,strong) UIView *Remview;
@property (nonatomic,assign) int clickNum;
@property (nonatomic,strong) commenTField *picCodeF;
@property (nonatomic,strong) UIImageView *codeImg;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏背景及标题颜色
//    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor purpleColor],NSForegroundColorAttributeName, nil]];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"登录";
    [self addsubViews];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *imge = [UIImage imageNamed:@"Dcontent.jpg"];
    CGFloat imgHH = imge.size.height *FScreenWidth/imge.size.width;
    FLog(@"图片的高度--%lf",imgHH);
    
}

#pragma mark -添加各个控件
-(void)addsubViews{
    //设置标识符，判断验证码出现（输错3次）
    _clickNum = 0;
    
    
    
    //设置rightButton的跳转
    UIBarButtonItem *reginBtn = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(pushRegisterVC)];
    
    self.navigationItem.rightBarButtonItem = reginBtn;
    
    //logo大图片
    _zicImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login1.png"]];
    _zicImg.frame = CGRectMake((FScreenWidth - 90)/2,50, 90, 90);
    [self.view addSubview:_zicImg];
    //大标题
    _titLable = [[UILabel alloc]init];
    _titLable.text = @"-放-框架";
    _titLable.textColor = [UIColor blackColor];
    _titLable.shadowColor = [UIColor blackColor];
    _titLable.textAlignment = NSTextAlignmentCenter;
    _titLable.font = [UIFont systemFontOfSize:24.0f];
    [self.view addSubview:_titLable];
    //账号输入框
    _txtNumberF = [[commenTField alloc]init];
    [_txtNumberF setImgName:[NSString stringWithFormat:@"YH1.png"] andPlaceHString:[NSString stringWithFormat:@"请输入您的用户名"] andSecureEntry:NO];
    [_txtNumberF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.view addSubview:_txtNumberF];
    
    //密码输入框
    _passWdF = [[commenTField alloc]init];
    [_passWdF setImgName:[NSString stringWithFormat:@"mima.png"] andPlaceHString:[NSString stringWithFormat:@"请输入您的登录密码"] andSecureEntry:YES];
    [self.view addSubview:_passWdF];
    
    //图片验证码输入框
    _picCodeF = [[commenTField alloc]init];
    [_picCodeF setImgName:[NSString stringWithFormat:@"code.png"] andPlaceHString:[NSString stringWithFormat:@"请输入验证码"] andSecureEntry:NO];
    //图片验证码
    _codeImg = [[UIImageView alloc]init];
    _codeImg.backgroundColor = [UIColor purpleColor];
    
    //添加登陆按钮
    _loginBtn = [[UIButton alloc]init];
    _loginBtn.backgroundColor = FRGBA(118.0, 0.0, 254.0,1.0);
    _loginBtn.layer.cornerRadius = 6;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(btnClikEvents) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    //添加记住密码
    _Remview = [[UIView alloc]init];
    _remTipLab = [[UILabel alloc]init];
    _rembPswBtn = [[UIButton alloc]init];
    _remTipLab.text = @"记住密码";
    _remTipLab.textColor = [UIColor darkGrayColor];
    _remTipLab.shadowColor = [UIColor darkGrayColor];

    _remTipLab.font = [UIFont systemFontOfSize:14.0];
    [_rembPswBtn setImage:[UIImage imageNamed:@"remb-no.png"] forState:UIControlStateNormal];
    [_rembPswBtn addTarget:self action:@selector(remberState:) forControlEvents:UIControlEventTouchUpInside];
    _rembPswBtn.tag = 2;
    
    [_Remview addSubview:_rembPswBtn];
    [_Remview addSubview: _remTipLab];
    [self.view addSubview:_Remview];
    //添加忘记密码按钮
    _forgPswBtn = [[UIButton alloc]init];
    [_forgPswBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    _forgPswBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_forgPswBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_forgPswBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
     [_forgPswBtn setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _forgPswBtn.tag = 3;
    [_forgPswBtn addTarget:self action:@selector(remberState:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgPswBtn];
    //添加约束
    [self constraint];
    
}
#pragma mark - 约束
-(void)constraint{

    FWeakSelf(self);
    [_titLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view).with.offset(-(FScreenWidth -150)/2);
        make.left.equalTo(weakself.view).with.offset((FScreenWidth -150)/2);
        make.top.equalTo(weakself.zicImg.mas_bottom).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(150, 60));
    }];
    
    [weakself.txtNumberF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titLable.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
    }];
    
    [weakself.passWdF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.txtNumberF.mas_bottom).with.offset(20);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
    }];
    
    [weakself.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWdF.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.right.equalTo(weakself.view).with.offset(-30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
    }];
    
    [weakself.Remview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.loginBtn.mas_bottom).with.offset(10);
        make.left.equalTo(weakself.loginBtn.mas_left).with.offset(5);
        make.size.mas_equalTo(CGSizeMake((FScreenWidth-60)/2, 20));
        
    }];
    
    [weakself.remTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(weakself.Remview).with.offset(0);
        make.size.mas_equalTo(CGSizeMake((FScreenWidth-60)/2-25, 20));
        
    }];
   
    [weakself.rembPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.top.equalTo(weakself.Remview).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    [weakself.forgPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.loginBtn.mas_bottom).with.offset(10);
        make.right.equalTo(weakself.loginBtn.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake((FScreenWidth-60)/2, 20));
    }];
}

-(void)btnClikEvents{
    
    NSString *accountS = [NSString stringWithFormat:@"%@",_txtNumberF.text];
    NSString *passWS = [NSString stringWithFormat:@"%@",_passWdF.text];
    if ([accountS isEqualToString:@"(null)"] || [accountS length] <= 0) {
        _clickNum ++;
        
        if (_clickNum == 3) {
            
            FLog(@"----错误了%i次了",_clickNum);
            //
            [self picCodeApprence];
            
            
        }
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"账户不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击取消");
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        return;
    }
    
    if ([passWS length] <= 5) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度不能小于6位" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击确认");
        }]];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            FLog(@"点击取消");
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
    }

    //认证账号密码
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    hud.label.text = @"正在验证账号密码";
    hud.delegate = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self hudWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
           //登录成功，跳转至首页
            AppDelegate *appDelegates = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegates loginIn];
           
            
        });
        
    });
    
    return;
}

#pragma mark - 记住密码的状态
-(void)remberState:(UIButton *)btn{
    
    if (btn.tag == 2) {
        _rembPswBtn.tag --;
       [btn setImage:[UIImage imageNamed:@"remb-yes.png"] forState:UIControlStateNormal];

 
        
        return;
    }
    if (btn.tag == 1) {
        _rembPswBtn.tag ++;
        [btn setImage:[UIImage imageNamed:@"remb-no.png"] forState:UIControlStateNormal];

        
        return;
    }
    
    if (btn.tag == 3) {
        ResetPWVController *RVC = [[ResetPWVController alloc]init];
        
        [self.navigationController pushViewController:RVC animated:YES];
    }
    
}

#pragma mark - HUD执行的方法
-(void)hudWork{
    
//    HomeVViewController *homeVC = [[HomeVViewController alloc]init];
//    self.navigationController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:homeVC animated:YES];
    //返回主线程执行修改UI
    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(3);
        if (_rembPswBtn.tag == 1) {
            FUserDefaultSetObjectForKey(_txtNumberF.text, @"account");
            FUserDefaultSetObjectForKey(_passWdF.text, @"passWord");
            FLog(@"%@",[MD5_NSString MD5WithString:_passWdF.text]);
            
            FLog(@"%@,%@,%ld",FUserDefaultObjectForKey(@"account"),FUserDefaultObjectForKey(@"passWord"),_rembPswBtn.tag);
            return;
        }else{
            FUserDefaultRemoveObjectForKey(@"account");
            FUserDefaultRemoveObjectForKey(@"passWord");
            FLog(@"%@,%@,%ld",FUserDefaultObjectForKey(@"account"),FUserDefaultObjectForKey(@"passWord"),_rembPswBtn.tag);
            return;
        }
        
        

    });
    
    
    
}

#pragma mark - 跳转到注册页
-(void)pushRegisterVC{
    RegisterVController *regVC = [[RegisterVController alloc]init];
   
    
    [self.navigationController pushViewController:regVC animated:YES];
}


//登陆输错多次，验证码出现
-(void)picCodeApprence{
    FWeakSelf(self);
    
    [weakself.loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWdF.mas_bottom).with.offset(120);
        make.left.equalTo(weakself.view).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60, 40));
    }];
    [self.view addSubview:_picCodeF];
    [weakself.picCodeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWdF.mas_bottom).with.offset(30);
        make.left.equalTo(weakself.view).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(FScreenWidth-60-100, 40));
    }];
    
    [self.view addSubview:_codeImg];
    [weakself.codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.passWdF.mas_bottom).with.offset(35);
        make.right.equalTo(weakself.view).with.offset(-35);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
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
