//
//  NHHousingScroller.m
//  NHScrollMasPro
//
//  Created by hu jiaju on 16/6/4.
//  Copyright © 2016年 hu jiaju. All rights reserved.
//

#import "NHHousingScroller.h"

@interface NHHousingScroller ()

@property (nonatomic, strong) UIScrollView *scroller;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) UILabel *header,*footer,*houser;
@property (nonatomic, strong) UIButton *housingBtn;

@end

@implementation NHHousingScroller

static NSString *constString = @"相声（Crosstalk），一种民间说唱曲艺。相声一词，古作象生，原指模拟别人的言行，后发展为象声。象声又称隔壁象声。相声起源于华北地区的民间说唱曲艺，在明朝即已盛行。经清朝时期的发展直至民国初年，相声逐渐从一个人摹拟口技发展成为单口笑话，名称也就随之转变为相声。一种类型的单口相声，后来逐步发展为多种类型：单口相声、对口相声、群口相声，综合为一体。相声在两岸三地有不同的发展模式。中国相声有三大发源地：北京天桥、天津劝业场、三不管儿和南京夫子庙。相声艺术源于华北，流行于京津冀，普及于全国及海内外，始于明清，盛于当代。主要采用口头方式表演。表演形式有单口相声、对口相声、群口相声等，是扎根于民间、源于生活、又深受群众欢迎的曲艺表演艺术形式。相声鼻祖为张三禄，著名流派有“马（三立）派”、“侯（宝林）派”、“常（宝堃）派”、“苏（文茂）派”、“马（季）派”等。著名相声表演大师有马三立、侯宝林、常宝堃、苏文茂、刘宝瑞等多人。二十世纪晚期，以侯宝林、马三立为首的一代相声大师相继陨落，相声事业陷入低谷。2005年起，凭借在网络视频网站等新兴媒体的传播，相声演员郭德纲及其德云社异军突起，使公众重新关注相声这一艺术门类，实现了相声的二次复兴。";

- (NSArray *)generateDataSource {
    NSMutableArray *tmp = [NSMutableArray array];
    
    int minLen = 7;
    int maxLen = (int)[constString length];
    int counts = 19;
    for (int i = 0; i < counts; i++) {
        int ret = [self random:minLen to:maxLen];
        NSString *tmp_str = [constString substringToIndex:ret];
        [tmp addObject:tmp_str];
    }
    
    return [tmp copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"housing";
    //需要指定Scroller的bounds 不然无响应
    CGRect bounds = self.view.bounds;
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:bounds];
    scrollV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
    container.backgroundColor = [UIColor whiteColor];
    [scrollV addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollV);
        make.width.equalTo(scrollV);
    }];
    
    //setting
    UIFont *font = [UIFont systemFontOfSize:20];
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(CGRectGetWidth(bounds), MAXFLOAT);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSString *tmp = [constString substringToIndex:constString.length * 0.5];
    bounds = [tmp boundingRectWithSize:size options:opts attributes:attributes context:nil];
    NSLog(@"size:%@***bounds:%@",NSStringFromCGSize(size),NSStringFromCGRect(bounds));
    //header
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = tmp;
    //[label sizeToFit];
    [container addSubview:label];
    self.header = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(container.mas_top);
        make.left.and.right.equalTo(container);
        make.height.equalTo(@(bounds.size.height));
    }];
    //btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"open" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(openCloseEvent) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:btn];
    self.housingBtn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.right.equalTo(container);
        make.height.equalTo(@(40));
    }];
    bounds = [constString boundingRectWithSize:size options:opts attributes:attributes context:nil];
    NSLog(@"size:%@***bounds:%@",NSStringFromCGSize(size),NSStringFromCGRect(bounds));
    //footer
    label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = constString;
    [label sizeToFit];
    [container addSubview:label];
    self.footer = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom);
        make.left.and.right.equalTo(container);
        make.height.equalTo(@(bounds.size.height));
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_bottom);
    }];
    
}

- (void)openCloseEvent {
    self.isOpen = !self.isOpen;
    NSString *title = self.isOpen?@"close":@"open";
    [self.housingBtn setTitle:title forState:UIControlStateNormal];
    CGRect bounds = self.view.bounds;
    UIFont *font = [UIFont systemFontOfSize:20];
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(CGRectGetWidth(bounds), MAXFLOAT);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSString *tmp = [constString copy];
    if (!self.isOpen) {
        tmp = [constString substringToIndex:constString.length * 0.5];
    }
    bounds = [tmp boundingRectWithSize:size options:opts attributes:attributes context:nil];
    NSLog(@"size:%@***bounds:%@",NSStringFromCGSize(size),NSStringFromCGRect(bounds));
    self.header.text = tmp;
    [self.header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(bounds.size.height));
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
