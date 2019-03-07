//
//  ViewController.m
//  UIDynamic
//
//  Created by 菊长 on 2019/3/3.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redview = [[UIView alloc]init];
    redview.backgroundColor = [UIColor redColor];
    redview.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:redview];
    self.redView = redview;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //根据某一个范围创建动画者对象
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //根据某一个动力学元素,创建行为
    //重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    //方向
//    gravity.angle = M_PI_2;
//    gravity.gravityDirection = CGVectorMake(1, 1);
    gravity.magnitude = 2;
    //把这个行为添加到动画者当中
    [self.animator addBehavior:gravity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
