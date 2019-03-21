//
//  ViewController.m
//  毛毛虫案例
//
//  Created by 菊长 on 2019/3/12.
//  Copyright © 2019 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *att;
@property (nonatomic, strong) NSMutableArray *bodys;
@end

@implementation ViewController
- (UIDynamicAnimator *)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (NSMutableArray *)bodys{
    if (!_bodys) {
        _bodys = [NSMutableArray array];
    }
    return _bodys;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 9; i++) {
        UIView *wormView = [[UIView alloc]init];
        CGFloat w = 30;
        CGFloat h =30;
        CGFloat x = i*w;
        CGFloat y = 100;
        wormView.frame = CGRectMake(x, y, w, h);
        wormView.backgroundColor = [UIColor redColor];
        wormView.layer.cornerRadius = w *0.5;
        wormView.layer.masksToBounds = YES;
        if (i == 8) {
            wormView.frame = CGRectMake(x, y-h*0.5, 2*w, 2*h);
            wormView.layer.cornerRadius = w;
            wormView.userInteractionEnabled = YES;
            //添加手势
            UIPanGestureRecognizer *pin = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            [wormView addGestureRecognizer:pin];
        }
        [self.bodys addObject:wormView];
        [self.view addSubview:wormView];
    }
    for (int i = 0; i < self.bodys.count - 1; ++i) {
        //附着
        UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc]initWithItem:self.bodys[i] attachedToItem:self.bodys[i+1]];
        [self.animator addBehavior:attach];
    }
    //重力
    UIGravityBehavior *g = [[UIGravityBehavior alloc]initWithItems:self.bodys];
    [self.animator addBehavior:g];
    //碰撞
    UICollisionBehavior *coll = [[UICollisionBehavior alloc]initWithItems:self.bodys];
    coll.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:coll];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)pan:(UIPanGestureRecognizer *)sender{
    //手指位置
    CGPoint p = [sender locationInView:self.view];
    //创建动画者对象 lazy
    
    //创建附着行为
    if (!_att) {
        UIAttachmentBehavior *att = [[UIAttachmentBehavior alloc]initWithItem:sender.view attachedToAnchor:p];
        self.att = att;
    }
    self.att.anchorPoint = p;
    
    //添加到动画者中
    [self.animator addBehavior:self.att];
    //撒手的时候,移除掉手指和头的附着行为
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:self.att];
    }
}

@end
