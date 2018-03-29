//
//  FHeadfile.h
//  FItemsBase
//
//  Created by 连杰 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#ifndef FHeadfile_h
#define FHeadfile_h
#define FMAIN_API @""


/** 屏幕宽度 */
#define FScreenWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define FScreenHeight [UIScreen mainScreen].bounds.size.height
/** 比例 */
#define FScale   [[UIScreen mainScreen] bounds].size.width/320
/** 定义自己的log */
#ifdef DEBUG
#define FLog(...) NSLog(@"%s 第%d行\n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define FLog(...)
#endif
/** 弱引用/强引用 */
#define FWeakSelf(type) __weak typeof(type) weak##type = type;
#define FStrongSelf(type) __strong typeof(type) type = weak##type;
/** 设置view圆角和边框 */
#define FViewBorderRadius(View,Radius,Width,Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/** 安全释放宏 */
#define Release_Safe(_control) [_control release], _control = nil;
/*
 *   传入RGBA四个参数，得到颜色
 *   美工和设计通过PS给出的色值是0~255
 *   苹果的RGB参数给出的是0~1
 *   那我们就让美工给出的 参数/255 得到一个0-1之间的数
 */
#define FRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
/** 传入RGB三个参数，得到颜色 */
#define FRGB(r,g,b) FRGBA(r,g,b,1.f)
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 取得随机颜色 */
#define FGETRandomColor FRGB(arc4random()%256,arc4random()%256,arc4random()%256)

//字符串是否为空
#define FStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
//数组是否为空
#define FArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || [array count] < 1 ? YES : NO)
//字典是否为空
#define FDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || [dic allKeys].count < 1 ? YES : NO)
//对象是否为空
#define FObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

/**
 *  the saving objects      存储对象
 *
 *  @param __VALUE__ V
 *  @param __KEY__   K
 *
 *  @return
 */
#define FUserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
/**
 *  get the saved objects       获得存储的对象
 */
#define FUserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define FUserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
/** 子线程 */
#define FDisPatch_Global(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
/** 主线程 */
#define FDisPatch_Main(block) dispatch_async(dispatch_get_main_queue(),block)

/** 获取通知中心 */
#define FNotificationCenter [NSNotificationCenter defaultCenter]
//设备型号
#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )


//系统版本
#define IS_IOS_VERSION   floorf([[UIDevice currentDevice].systemVersion floatValue]
#define IS_IOS_5    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==5.0 ? 1 : 0
#define IS_IOS_6    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==6.0 ? 1 : 0
#define IS_IOS_7    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==7.0 ? 1 : 0
#define IS_IOS_8    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==8.0 ? 1 : 0
#define IS_IOS_9    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==9.0 ? 1 : 0
#define IS_IOS_10    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==10.0 ? 1 : 0
#define IS_IOS_11    floorf([[UIDevice currentDevice].systemVersion floatValue]) ==11.0 ? 1 : 0



#endif /* FHeadfile_h */
