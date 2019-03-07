//
//  ViewController.m
//  UIDynamicAttach2
//
//  Created by 菊长 on 2019/3/7.
//  Copyright © 2019 菊长. All rights reserved.
//

#import "ViewController.h"

@interface BGView: UIView
@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end;
@end

@implementation BGView
- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.start];
    [path addLineToPoint:self.end];
    [path stroke];
}
@end
@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attach;
@end

@implementation ViewController
- (void)loadView{
    self.view = [[BGView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redview = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    redview.backgroundColor = [UIColor redColor];
    [self.view addSubview:redview];
    self.redView = redview;
    UIView *blueview = [[UIView alloc]initWithFrame:CGRectMake(250, 100, 100, 100)];
    blueview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueview];
    self.blueView = blueview;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.view];
    //创建动画者对象
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //创建行为
    self.attach = [[UIAttachmentBehavior alloc]initWithItem:self.redView attachedToItem:self.blueView];
    //把行为添加到动画者对象中
    [self.animator addBehavior:self.attach];
    //添加重力
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[self.redView]];
    [self.animator addBehavior:gravity];
}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *t = [touches anyObject];
//    CGPoint p = [t locationInView:t.view];
//    self.attach.anchorPoint = p;
//    __weak ViewController *weakSelf = self;
//    self.attach.action = ^{
//        BGView *bgview = (BGView *)weakSelf.view;
//        bgview.start = weakSelf.redView.center;
//        bgview.end = p;
//        [bgview setNeedsDisplay];
//    };
//}
@end
