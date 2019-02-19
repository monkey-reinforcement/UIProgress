//
//  ViewController.m
//  uitapGesture
//
//  Created by 菊长 on 19/2/1.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer *layer;
@end

@implementation ViewController
/*CALayer
在iOS中,你能看得见摸得着的东西基本上都是UIView,比如一个按钮,一个文本标签,一个文本输入框,一个图标等,这些都是UIView
其实UIView之所以能显示在屏幕上,完全是因为它内部的一个图层
在创建UIView对象时,UIView内部会自动创建一个图层(即CALayer对象),通过UIView的layer属性可以访问这个层;@property(nonatomic,readonly,retain)CALayer *layer;
 当UIView需要显示到屏幕上时,会调用drawRect:方法进行绘图,并且会将所有内容绘制在自己的图层上,绘图完毕后,系统会将图层拷贝到屏幕上,于是就完成UIView的显示
 换句话说,UIView本身不具备显示的功能,是它内部的层才有显示功能
 CALayer和UIView的关系:CALayer负责视图中显示内容和动画
 UIView负责监听和响应事件
 */
- (void)viewDidLoad {
    [super viewDidLoad];
 /*   UIView *redview = [[UIView alloc]init];
    redview.frame = CGRectMake(100, 100, 100, 100);
    redview.backgroundColor = [UIColor redColor];
    redview.layer.borderWidth = 10;//边框
    redview.layer.borderColor = [UIColor greenColor].CGColor;
    redview.layer.shadowOffset = CGSizeMake(100, 100);//阴影
    redview.layer.shadowColor = [UIColor blueColor].CGColor;
    redview.layer.shadowOpacity = 1;
    //圆角
    redview.layer.cornerRadius = 50;
    redview.layer.masksToBounds = YES;
    //postion属性和view.center的关系//默认center跑到position的位置上
    redview.layer.position = CGPointMake(0, 0);
    [self.view addSubview:redview];
    */
    
    /*
     *手动创建layer
     */
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(200, 200);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    self.layer = layer;
    [self.view.layer addSublayer:layer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:t.view];
    self.layer.position = p;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
