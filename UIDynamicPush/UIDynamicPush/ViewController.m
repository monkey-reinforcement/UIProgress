//
//  ViewController.m
//  UIDynamicPush
//
//  Created by 菊长 on 2019/3/11.
//  Copyright © 2019 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redview= [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    redview.backgroundColor = [UIColor redColor];
    [self.view addSubview:redview];
    
    self.redView = redview;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.view];
    //创建动画者
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //创建行为
    UIPushBehavior *push = [[UIPushBehavior alloc]initWithItems:@[self.redView] mode:UIPushBehaviorModeContinuous];
    push.magnitude = 1;//量级
    //方向
   // push.angle = M_PI;//用角度的形式设置方向
    CGFloat offsetX = (p.x - self.redView.center.x)/50;
    CGFloat offsetY = (p.y - self.redView.center.y)/50;
    push.pushDirection = CGVectorMake(offsetX, offsetY);
    //把行为添加到动画者中
    [self.animator addBehavior:push];
}

@end
