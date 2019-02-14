//
//  CGView.m
//  autolayout
//
//  Created by 菊长 on 18/12/27.
//  Copyright © 2018年 菊长. All rights reserved.
//

#import "CGView.h"
#define kButtonCount 9

@interface CGView ()
@property (nonatomic, strong) NSMutableArray *btnsArr;
@property (nonatomic, strong) NSMutableArray *linBtns;
@property (nonatomic, assign) CGPoint currentPoint;
@end
@implementation CGView

- (NSMutableArray *)btnsArr{
    if (!_btnsArr) {
        _btnsArr = [NSMutableArray array];
    }
    return _btnsArr;
}
- (NSMutableArray *)linBtns{
    if (!_linBtns) {
        _linBtns = [NSMutableArray array];
    }
    return _linBtns;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    for (int i = 0; i < kButtonCount; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        //设置错误图片
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted_wrong"] forState:UIControlStateDisabled];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        //添加按钮到数组中
        [self.btnsArr addObject:btn];
    }
}
//连线
- (void)drawRect:(CGRect)rect{
    if (self.linBtns.count == 0) {
        return;
    }
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.linBtns.count; i++) {
        UIButton*btn = self.linBtns[i];
        if (i == 0) {
            //第一个点设置为起点
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    //连线到手指的位置
    [path addLineToPoint:self.currentPoint];
    [[UIColor redColor]set];
    [path setLineWidth:10];
    //设置连接处的 样式
    [path setLineJoinStyle:kCGLineJoinRound];
    //设置头尾样式
    [path setLineCapStyle:kCGLineCapRound];
    [path stroke];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = 74;
    CGFloat h = w;
    int colCount = 3;
    CGFloat margin = (self.frame.size.width - 3*w) / 4;
    
    for (int i = 0; i < self.btnsArr.count; i++) {
        CGFloat x = (i % colCount)*(margin+w) + margin;
        CGFloat y = (i / colCount)*(margin + w) + margin;
        [self.btnsArr[i] setFrame:CGRectMake(x, y, w, h)];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    //
    for (int i = 0; i < self.btnsArr.count; i++) {
        UIButton *btn = self.btnsArr[i];
        if (CGRectContainsPoint(btn.frame, p)) {
            btn.selected = YES;
            [self.linBtns addObject:btn];
        }
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    self.currentPoint = [t locationInView:t.view];
    for (int i = 0; i < self.btnsArr.count; i++) {
        UIButton *btn = self.btnsArr[i];
        //判断是否在手指点击的范围内
        if (CGRectContainsPoint(btn.frame, p)) {
            btn.selected = YES;
            //判断数组是否包含该button
            if (![self.linBtns containsObject:btn]) {
                //添加到连线数组中
                [self.linBtns addObject:btn];
            }
        }
    }
    [self setNeedsDisplay];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
//手指离开view的时候调用
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //修改最后手指的位置为需要连线的最后一个按钮的中心,解决最后一根线多出来的问题
    self.currentPoint = [[self.linBtns lastObject] center];
    //重绘
    [self setNeedsDisplay];
    for (int i = 0; i < self.linBtns.count; i++) {
        UIButton *btn = self.linBtns[i];
        //让btn变成错误的状态同时,需要取消选中状态
        btn.selected = NO;
        //
        btn.enabled = NO;
    }
    //拼接密码
    NSString *password = @"";
    for (int i = 0; i < self.linBtns.count; i++) {
        UIButton *btn = self.linBtns[i];
        password = [password stringByAppendingString:[NSString stringWithFormat:@"%ld", btn.tag]];
    }
    if (self.passwordBlock) {
        self.passwordBlock(password);
    }
    //关闭用户交互
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self clear];
        self.userInteractionEnabled = YES;//开启交互
    });
}
//回复初始状态
- (void)clear{
    for (int i = 0; i < self.btnsArr.count; i++) {
        UIButton *btn = self.btnsArr[i];
        btn.selected = NO;
        btn.enabled = YES;
    }
    //清空所有的连线的btn
    [self.linBtns removeAllObjects];
    [self setNeedsDisplay];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return nil;
}
@end
