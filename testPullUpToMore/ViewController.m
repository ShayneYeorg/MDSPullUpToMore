//
//  ViewController.m
//  MDSPullUpToMore
//
//  Created by 杨淳引 on 16/2/3.
//  Copyright © 2016年 shayneyeorg. All rights reserved.
//

//  分3步来使用这个控件

#import "ViewController.h"
//第1步：引进文件
#import "MDSPullUpToMore.h"

@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configScrollView];
}

- (void)configScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.scrollView setContentSize:CGSizeMake(0, self.scrollView.frame.size.height+0.5)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    UIView *testView = [[UIView alloc]initWithFrame:self.scrollView.frame];
    testView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:testView];
    
    //第2步：为UIScrollView或UIScrollView的子类添加操作块
    __weak ViewController *weakSelf = self;
    [self.scrollView addPullUpToMoreWithActionHandler:^{
        //在这里添加上拉加载时的操作语句
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //使用这个语句来停止加载
            [weakSelf.scrollView.pullUpToMoreView stopAnimation];
            
            //使用这个语句将控件设置为不可用
            //weakSelf.scrollView.pullUpToMoreView.canMore = NO;
        });
    }];
    
}

#pragma mark - UIScrollViewDelegate
//第3步：重写UIScrollViewDelegate协议的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [scrollView didScroll];
    }
}

/*
 当拖动scrollView的时候，页面会不断调用scrollViewDidScroll:方法；
 scrollViewDidScroll:方法会调用到控件的didScroll方法；
 didScroll方法会根据实时的contentOffset来判断控件的状态并不断调用setState:方法；
 setState:方法是控件最核心的方法，当状态一旦改变，它就会根据状态让控件呈现不同的效果。
 */

@end


