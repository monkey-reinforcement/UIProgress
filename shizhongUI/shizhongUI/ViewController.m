//
//  ViewController.m
//  shizhongUI
//
//  Created by 菊长 on 2019/2/20.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer *second;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *clock = [[CALayer alloc]init];
    clock.bounds = CGRectMake(0, 0, 200, 200);
    clock.position = CGPointMake(200, 200);
    clock.contents = (__bridge id)[UIImage imageNamed:@"time"].CGImage;
    clock.cornerRadius = 100;
    clock.masksToBounds = YES;
    //创建秒针
    CALayer *second = [[CALayer alloc]init];
    self.second = second;
    second.bounds = CGRectMake(0, 0, 2, 100);
    second.position = clock.position;
    second.backgroundColor = [UIColor redColor].CGColor;
    second.anchorPoint = CGPointMake(0.5, 0.7);
    [self.view.layer addSublayer:clock];
    [self.view.layer addSublayer:second];
    //定时器方法1
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    //方法2
    //CADisplayLink是一个计时器,可以使绘图代码与视图的刷新频率保持同步
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self timeChange];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)timeChange{
    //一秒钟旋转角度
    CGFloat angel = 2*M_PI / 60;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"ss";
    CGFloat time = [[formatter stringFromDate:date] intValue];
//    //日历获取时间方法2
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    CGFloat time = [cal component:NSCalendarUnitSecond fromDate:date];
    self.second.affineTransform = CGAffineTransformMakeRotation(time*angel);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
