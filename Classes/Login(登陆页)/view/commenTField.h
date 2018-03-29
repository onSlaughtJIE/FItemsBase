//
//  commenTField.h
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//
//自定义输入框：左图

#import <UIKit/UIKit.h>

@interface commenTField : UITextField
@property (nonatomic,copy) NSString *placeHString;
@property (nonatomic,copy) NSString *imgName;

@property (nonatomic,assign) BOOL secureTEntry;

/**
*
*设置输入框的图片和属性
**/
-(void)setImgName:(NSString *)imgName andPlaceHString:(NSString *)placeHSting andSecureEntry:(BOOL )secureTEntry;

@end
