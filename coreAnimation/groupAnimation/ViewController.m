//
//  ViewController.m
//  groupAnimation
//
//  Created by 菊长 on 2019/2/26.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redView = [[UIView alloc]init];
    redView.frame = CGRectMake(100, 100, 50, 50);
    redView.backgroundColor = [UIColor redColor];
    self.layer = redView.layer;
    [self.view addSubview:redView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //组动画
    //创建动画
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    //创建基本动画
    CABasicAnimation *anim = [[CABasicAnimation alloc]init];
    anim.keyPath = @"transform.rotation";
    anim.byValue = @(2*M_PI);
    //关键帧动画
    CAKeyframeAnimation *anim1 = [[CAKeyframeAnimation alloc]init];
    //怎么做动画
    anim1.keyPath = @"position";
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    anim1.path = path.CGPath;//路径
    //操作
    group.animations = @[anim, anim1];
    group.duration = 3;
    group.repeatCount = INT_MAX;
    //添加动画
    [self.layer addAnimation:group forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
