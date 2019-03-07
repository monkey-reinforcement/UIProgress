//
//  ViewController.m
//  collisionBound
//
//  Created by 菊长 on 2019/3/4.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;
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
    
    UIView *blueview = [[UIView alloc]init];
    blueview.backgroundColor = [UIColor blueColor];
    blueview.frame = CGRectMake(170, [UIScreen mainScreen].bounds.size.height - 50, 50, 50);
    [self.view addSubview:blueview];
    self.blueView = blueview;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //根据某一个范围创建动画者对象
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //根据某一个动力学元素,创建行为
    //重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    //碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.redView, self.blueView]];
    //把引用view的bounds变成边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    //碰撞模式
    collision.collisionMode = UICollisionBehaviorModeEverything;
    //添加碰撞边界
    //以一条线为边界
//    [collision addBoundaryWithIdentifier:@"bound" fromPoint:CGPointMake(0, 200) toPoint:CGPointMake(200, 250)];
    //以一个自定义路径为边界
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.blueView.frame] ;
    [collision addBoundaryWithIdentifier:@"keyu" forPath:path];
    //把这个行为添加到动画者当中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
