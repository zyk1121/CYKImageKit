//
//  ViewController.m
//  CYKImageKit
//
//  Created by zhangyuanke on 15/10/1.
//  Copyright (c) 2015年 meituan. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
#import "CYKImageKit.h"

@interface ViewController ()

@property (nonatomic, strong) UIImage *srcImage;
@property (nonatomic, strong) UIImageView *srcImageView;
@property (nonatomic, strong) UIImageView *dstImageView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _srcImage = ({
        UIImage *image = [UIImage imageNamed:@"lena.jpg"];
        image;
    });
    
    _srcImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = _srcImage;
        [self.view addSubview:imageView];
        imageView;
    });
    
    _button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"水印处理" forState:UIControlStateNormal];
        [button setTitle:@"水印处理" forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(imageProcess) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    _dstImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.view addSubview:imageView];
        imageView.hidden = YES;
        imageView;
    });
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.srcImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
        make.centerX.equalTo(self.view);
    }];
    
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.srcImageView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
    }];
    
    [self.dstImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).offset(30);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
        make.centerX.equalTo(self.view);
    }];
}

// 图像处理
- (void)imageProcess
{
    UIImage *dstImage = [CYKImageKit watermarkImageWithImage:self.srcImage andLogoText:@"文字水印 文字水印"];
    self.dstImageView.image = dstImage;
    self.dstImageView.hidden = NO;
}

@end
