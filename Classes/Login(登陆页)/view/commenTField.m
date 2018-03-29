//
//  commenTField.m
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "commenTField.h"

@implementation commenTField

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setImgName:_imgName andPlaceHString:_placeHString andSecureEntry:_secureTEntry];
        
    }
    return self;
}

-(void)setImgName:(NSString *)imgName andPlaceHString:(NSString *)placeHSting andSecureEntry:(BOOL)secureTEntry{
 
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.textColor = [UIColor blackColor];
    
    self.placeholder = placeHSting;
//    NSMutableAttributedString *placeHol = [[NSMutableAttributedString alloc]initWithString:_placeHString];
//    [placeHol addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, _placeHString.length)];

//    [self setValue:[UIColor darkGrayColor] forKey:@"placeHSting.textColor"];
    //修改placeHolder的字体颜色及大小
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    [self setValue:[UIFont boldSystemFontOfSize:15.0] forKeyPath:@"placeholderLabel.font"];
    

    self.adjustsFontSizeToFitWidth = YES;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.secureTextEntry = secureTEntry;
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [FRGB(96, 96, 96) CGColor] ;
    //首字母不大写
    self.autocapitalizationType = UITextBorderStyleNone;
    //添加输入框左边小头像
    UIView *leftVTF = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *leftImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName]];
    leftImg.frame = CGRectMake(6, 3, 24, 24);
    [leftVTF addSubview:leftImg];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftVTF;
    
    
}





@end
