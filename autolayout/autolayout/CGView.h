//
//  CGView.h
//  autolayout
//
//  Created by 菊长 on 18/12/27.
//  Copyright © 2018年 菊长. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGView : UIView
@property (nonatomic, assign) CGFloat progressValue;
@property (nonatomic, copy) void (^passwordBlock)(NSString *);
@end
