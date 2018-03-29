//
//  GuideViewController.m
//  FItemsBase
//
//  Created by 放 on 2018/3/28.
//  Copyright © 2018年 放. All rights reserved.
//

#import "GuideViewController.h"
#define FPageCount 3
@interface GuideViewController ()<UIScrollViewDelegate>
{
    // 创建页码控制器
    UIPageControl *pageControl;
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, FScreenWidth, FScreenHeight)];
    for (int i=0; i<FPageCount; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Guide%d",i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(FScreenWidth * i, 0, FScreenWidth, FScreenHeight)];
        // 在最后一页创建按钮
        if (i == FPageCount - 1) {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            self.button = [UIButton buttonWithType:UIButtonTypeSystem];
            _button.frame = CGRectMake(FScreenWidth / FPageCount, FScreenHeight * 7 / 8, FScreenWidth / FPageCount, FScreenHeight / 16);
            [_button setTitle:@"立即体验" forState:UIControlStateNormal];
            [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _button.layer.borderWidth = 2;
            _button.layer.cornerRadius = 5;
            _button.clipsToBounds = YES;
            [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            _button.layer.borderColor = [UIColor orangeColor].CGColor;
            [imageView addSubview:_button];
        }
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(FScreenWidth * FPageCount, FScreenHeight);
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(FScreenWidth / FPageCount, FScreenHeight * 15 / 16, FScreenWidth / FPageCount, FScreenHeight / 16)];
    // 设置页数
    pageControl.numberOfPages = FPageCount;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
}
- (void)buttonAction:(UIButton *)sender {
    self.guideBtnBlock(sender);
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
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
