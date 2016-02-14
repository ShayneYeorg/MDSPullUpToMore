//
//  ViewController.m
//  MDSPullUpToMore
//
//  Created by 杨淳引 on 16/2/3.
//  Copyright © 2016年 shayneyeorg. All rights reserved.
//

//  分4步来使用这个控件

#import "ViewController.h"
//第1步：引进文件
#import "MDSPullUpToMore.h"

@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configScrollView];
    [self checkData];
}

#pragma mark - Private

- (void)configScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.scrollView setContentSize:CGSizeMake(0, self.scrollView.frame.size.height+0.5)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    UIView *testView = [[UIView alloc]initWithFrame:self.scrollView.frame];
    testView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:testView];
    
    //第2步：为UIScrollView或UIScrollView的子类添加上拉加载更多时的操作块
    __weak ViewController *weakSelf = self;
    [self.scrollView addPullUpToMoreWithActionHandler:^{
        //在这里添加上拉加载时的操作语句
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf checkData];
        });
    }];
}

//获取页面数据的方法
- (void)checkData {
    //获取数据的代码
    //...
    
    //第3步：在获取数据后，要根据是否还有后续数据来设定控件的状态
    //如果还有后续数据的话，调用stopAnimation方法，这个方法会把控件的state设置为hidden，以后仍然可以继续上拉加载更多
    //如果没有后续数据了，设置canMore=NO，这个方法会把控件的state设置为noMore，上拉不会再加载更多
    
    //if(还有后续数据)
    [self.scrollView.pullUpToMoreView stopAnimation];
    //else
//    self.scrollView.pullUpToMoreView.canMore = NO;
}

#pragma mark - UIScrollViewDelegate

//第4步：重写UIScrollViewDelegate协议的方法
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

/*
 还有一点需要注意：
 控件会根据scrollView.contentSize.height是否大于scrollView.height来判断要不要显示控件（内容不满屏则不显示控件）；
 在setState:方法内就有这个判断；
 所以在加载完数据后（一般在checkData方法最后，此时已能最终确定数据是否满屏），需要调用一下setState:方法，让控件合理显示；
 stopAnimation和setCanMore:方法都会调用到setState:方法；
 */

@end



