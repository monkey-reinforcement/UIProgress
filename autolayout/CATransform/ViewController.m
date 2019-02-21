//
//  ViewController.m
//  CATransform
//
//  Created by 菊长 on 2019/2/20.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     *手动创建layer 控件的跟layer没有隐式动画
     */
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(200, 200);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.contents = (__bridge id)[UIImage imageNamed:@"image7"].CGImage;
    self.layer = layer;
    [self.view.layer addSublayer:layer];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //旋转
    self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI_4, 0, 1, 0);
    //缩放
    self.layer.transform= CATransform3DScale(self.layer.transform, 0.5, 1, 1);
    //平移
    self.layer.transform = CATransform3DTranslate(self.layer.transform, 10, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
