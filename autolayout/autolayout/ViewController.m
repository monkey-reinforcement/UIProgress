//
//  ViewController.m
//  autolayout
//
//  Created by 菊长 on 18/11/5.
//  Copyright © 2018年 菊长. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CGView.h"

@interface ViewController ()
@property (nonatomic, strong)CGView *cgview;
@property (weak, nonatomic) IBOutlet CGView *passwordView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置控制器的背景为一张图片(平铺)
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    //密码
    NSString *str = @"125";
    self.passwordView.passwordBlock = ^(NSString *pwd){
        if ([pwd isEqualToString:str]) {
            NSLog(@"正确");
        }
    };
    
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event{
    NSLog(@"%@", event);
}
- (void)changeNum:(UISlider *)sender{
    NSLog(@"%f", sender.value);
    self.cgview.progressValue = sender.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
