//
//  dbView.m
//  drawingboard
//
//  Created by 菊长 on 2019/2/27.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "dbView.h"
#import "DBBezierPath.h"

@interface dbView ()
@property (nonatomic, strong) NSMutableArray *paths;//管理路径的数组
@end

@implementation dbView

- (NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.lineWidth = 5;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (DBBezierPath *p in self.paths) {
        //设置连接处的样式
        [p setLineJoinStyle:kCGLineJoinRound];
        [p setLineCapStyle:kCGLineCapRound];
        [p.lineColor set];
        [p stroke];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.view];
    DBBezierPath *path = [[DBBezierPath alloc]init];
    [path setLineWidth:self.lineWidth];
    [path setLineColor:self.lineColor];
    [path moveToPoint:p];
    [self.paths addObject:path];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.view];
    DBBezierPath *path = self.paths.lastObject;
    [path addLineToPoint:p];
    [self setNeedsDisplay];
}
- (void)clear{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
- (void)back{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
- (void)erase{
    self.lineColor = self.backgroundColor;
}
@end
