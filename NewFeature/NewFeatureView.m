//
//  NewFeatureView.m
//  NewFeature
//
//  Created by libbbb on 2017/3/7.
//  Copyright © 2017年 libbbb. All rights reserved.
//

#import "NewFeatureView.h"
#import "Masonry.h"

@interface NewFeatureView ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIScrollView *scv;
@property(nonatomic,weak) UIPageControl *pc;
@end

@implementation NewFeatureView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

//初始化界面
- (void)setupUI {
    UIScrollView *scv = [[UIScrollView alloc]initWithFrame:self.bounds];
    //隐藏滚动条
    scv.showsVerticalScrollIndicator = NO;
    scv.showsHorizontalScrollIndicator = NO;
    //分页
    scv.pagingEnabled = YES;
    scv.delegate = self;
    //禁用弹簧效果
    scv.bounces = NO;
    [self addSubview:scv];
    self.scv = scv;
    
    //UIPageControl控件
    UIPageControl *pc = [[UIPageControl alloc]init];
    //当前页颜色
    pc.currentPageIndicatorTintColor = [UIColor blueColor];
    //底色
    pc.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pc];
    self.pc = pc;
    //自动布局
    [pc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-40);
    }];
    
}
//重写Pictures的Set方法
- (void)setPictures:(NSArray *)pictures{
    _pictures = pictures;
    for (int i = 0; i < _pictures.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageView.image = _pictures[i];
        //防止遮盖UIPageControl,图片在下面
        [self.scv insertSubview:imageView atIndex:0 ];
        
        //更多按钮
        UIButton *moreBtn = [[UIButton alloc]init];
        [moreBtn setImage:[UIImage imageNamed:@"common_more_black"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"common_more_white"] forState:UIControlStateHighlighted];
        [self addSubview:moreBtn];
        //自动布局
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.bottom.equalTo(self).offset(-40);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        [moreBtn addTarget:self action:@selector(clickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    self.scv.contentSize = CGSizeMake((_pictures.count +1) * self.frame.size.width, 0);
    self.pc.numberOfPages = _pictures.count;
}

#pragma mark - 更多按钮调用方法
- (void)clickMoreBtn {
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark - ScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = self.scv.contentOffset.x;
    CGFloat page = offsetX / self.frame.size.width;
    //滑动一般改变页码
    page += 0.5;
    self.pc.currentPage = (NSInteger)page;
    NSLog(@"page = %.2f,count = %zd",page,_pictures.count);
    self.pc.hidden = ((NSInteger)page == _pictures.count);
    
}

#pragma mark - ScrollView减速时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //滚动到最后一页移除新特性页面
    if (scrollView.contentOffset.x / self.frame.size.width == _pictures.count) {
        [self removeFromSuperview];
    }
    
}



@end
