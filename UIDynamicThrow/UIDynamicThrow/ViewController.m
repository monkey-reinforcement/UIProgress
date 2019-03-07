//
//  ViewController.m
//  UIDynamicThrow
//
//  Created by 菊长 on 2019/3/6.
//  Copyright © 2019 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)UIView *redView;
@property (nonatomic, strong) UIDynamicAnimator * animatior;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redview = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    redview.backgroundColor = [UIColor redColor];
    [self.view addSubview:redview];
    self.redView = redview;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.view];
    //动画者对象
    self.animatior = [[UIDynamicAnimator alloc]initWithReferenceView:self.redView];
    
    //创建一个行为
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.redView snapToPoint:p] ;
    snap.damping = 1;//
    //把行为添加到动画者当中
    [self.animatior addBehavior:snap];
}

@end
