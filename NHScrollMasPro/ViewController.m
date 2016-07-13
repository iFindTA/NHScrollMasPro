//
//  ViewController.m
//  NHScrollMasPro
//
//  Created by hu jiaju on 16/3/7.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"mas";
    //需要指定父view的bounds 不然无响应
    CGRect bounds = CGRectMake(10, 200, 300, 200);
    UIView *sv = [[UIView alloc] initWithFrame:bounds];
    sv.backgroundColor = [UIColor redColor];
    [self.view addSubview:sv];
    
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:bounds];
    scrollV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
    container.backgroundColor = [UIColor blueColor];
    [scrollV addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollV);
        make.width.equalTo(scrollV);
    }];
    
    CGFloat counts = 9;
    UIView *lastTmp;
    for (int i = 0; i < counts; i++) {
        CGFloat m_h = [self random:20 to:200];
        UIView *tmp = [[UIView alloc] initWithFrame:CGRectZero];
        tmp.backgroundColor = [self randomColor];
        [container addSubview:tmp];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.equalTo(@(m_h));
            if (lastTmp != nil) {
                make.top.mas_equalTo(lastTmp.mas_bottom);
            }else{
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        lastTmp = tmp;
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastTmp.mas_bottom);
    }];
    
}

- (CGFloat)random:(int)min to:(int)max {
    return arc4random() % (max-min) + min;
}

- (UIColor *)randomColor {
    int r = arc4random()%255;
    int g = arc4random()%255;
    int b = arc4random()%255;
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
