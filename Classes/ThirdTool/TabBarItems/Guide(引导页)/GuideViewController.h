//
//  GuideViewController.h
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^guideViewBtnBlock)();
@interface GuideViewController : UIViewController
@property (nonatomic ,strong)UIButton *button;
@property (nonatomic,copy)guideViewBtnBlock guideBtnBlock;
@end
