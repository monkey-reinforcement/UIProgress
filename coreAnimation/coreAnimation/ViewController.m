//
//  ViewController.m
//  coreAnimation
//
//  Created by 菊长 on 2019/2/25.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //coreAnimation是直接作用在CALayer上的,并非UIView
    //核心动画结束后会回到原来的位置
    UIView *redView = [[UIView alloc]init];
    redView.frame = CGRectMake(100, 100, 50, 50);
    redView.backgroundColor = [UIColor redColor];
    self.layer = redView.layer;
    [self.view addSubview:redView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
/*    //基本动画
    //1.创建基本动画(做什么动画)
    CABasicAnimation *anim = [[CABasicAnimation alloc]init];
    //怎么做动画
    anim.keyPath = @"position.x";
    anim.fromValue = @(10);//从哪到哪
    anim.toValue = @(300);
//    anim.byValue = @(10);//在自身基础上累加
    //不希望回到原来的位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    //添加动画(对谁做动画)
    [self.layer addAnimation:anim forKey:nil];
 */
    /*关键帧动画
     */
    //做什么动画
    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc]init];
    //怎么做动画
    anim.keyPath = @"position";
    //-------------1
//    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(150, 100)];
//    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(100, 150)];
//    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
//    anim.values = @[v1, v2,v3,v4];
    //------------
    //-----------2
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    anim.path = path.CGPath;//路径
    //------------
    anim.duration = 5;//时间
    anim.repeatCount = INT_MAX;//重复次数
    //对谁做动画
    [self.layer addAnimation:anim forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
