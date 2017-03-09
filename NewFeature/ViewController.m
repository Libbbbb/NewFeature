//
//  ViewController.m
//  NewFeature
//
//  Created by libbbb on 2017/3/7.
//  Copyright © 2017年 libbbb. All rights reserved.
//

#import "ViewController.h"
#import "NewFeatureView.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL hasNewFeature;

@end

@implementation ViewController
{
    NSArray<UIImage *> *_pictures;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasNewFeature = YES;
    [self loadData];
    [self setupUI];
    
    
}

- (void)setupUI {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cozy-control-car"]];
    imageView.frame = self.view.bounds;
    //修改图片模式
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    //判断新特性界面
    if (_hasNewFeature) {
        NewFeatureView *nfv = [[NewFeatureView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:nfv];
        nfv.pictures = _pictures;
    }
    
}

//加载本地图片
- (void)loadData {
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"common_h%zd",i+1]];
        [arrM addObject:image];
    }
    _pictures = arrM.copy;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
