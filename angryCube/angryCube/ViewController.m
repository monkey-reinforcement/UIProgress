//
//  ViewController.m
//  angryCube
//
//  Created by 菊长 on 2019/3/13.
//  Copyright © 2019 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollisionBehaviorDelegate>
@property (nonatomic, strong)UIView *bird;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UIView *pig;
@end

@implementation ViewController
-(UIDynamicAnimator *)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bird = [[UIView alloc]initWithFrame:CGRectMake(150, 300, 30, 30 )];
    bird.backgroundColor = [UIColor redColor];
    [self.view addSubview:bird];
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [bird addGestureRecognizer:pan];
    //
    UIView *pig = [[UIView alloc]initWithFrame:CGRectMake(500, 300, 30, 30)];
    pig.backgroundColor = [UIColor greenColor];
    [self.view addSubview:pig];
    self.pig = pig;
    //碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[pig, bird]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    //设置代理
    collision.collisionDelegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)pan:(UIPanGestureRecognizer *)sender{
    //获取移动的偏移量
    CGPoint offset = [sender translationInView:sender.view];
    //
    CGPoint currentPoint = [sender locationInView:self.view];
    //计算最后的偏移量
    CGFloat offsetx = sender.view.center.x - currentPoint.x;
    CGFloat offsety = sender.view.center.y - currentPoint.y;
    //计算拖动的距离
    CGFloat distance = sqrt(offsetx*offsetx+offsety*offsety);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, sender.view.center.x, sender.view.center.y, 100, 0, 2*M_PI, 1);
    if (CGPathContainsPoint(path, NULL, currentPoint, NO)) {
        if (sender.state == UIGestureRecognizerStateEnded) {
            //撒手的时候添加重力和推力
            UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[sender.view]];
            [self.animator addBehavior:gravity];
            self.gravity = gravity;
            UIPushBehavior *push = [[UIPushBehavior alloc]initWithItems:@[sender.view] mode:UIPushBehaviorModeInstantaneous];
            push.pushDirection = CGVectorMake(offsetx, offsety);
            push.magnitude = 0.7;
            [self.animator addBehavior:push];
        }
    }else{
        return;
    }
    
    
    //改变红色view的transform
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform,offset.x , offset.y);
    [sender setTranslation:CGPointZero inView:sender.view];
}
- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p{
    [self.gravity addItem:self.pig];
}
@end
