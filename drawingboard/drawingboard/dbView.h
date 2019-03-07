//
//  dbView.h
//  drawingboard
//
//  Created by 菊长 on 2019/2/27.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dbView : UIView
@property (nonatomic, assign) NSInteger lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
- (void)clear;
- (void)back;
- (void)erase;
@end
