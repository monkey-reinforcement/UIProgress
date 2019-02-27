//
//  ViewController.m
//  transitionAnimation
//
//  Created by 菊长 on 2019/2/26.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) NSInteger imageName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageName = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)imageChange:(UISwipeGestureRecognizer *)sender {
    self.imageName++;
    if (self.imageName == 4) {
        self.imageName = 0;
    }
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", self.imageName + 1]];
    //创建动画
    CATransition *anim = [[CATransition alloc]init];
    
    //操作
    anim.type = @"cube";
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        //从右网左
        anim.subtype = kCATransitionFromLeft;
    }else{
        anim.subtype = kCATransitionFromRight;
    }
    //添加动画
    [self.imageView.layer addAnimation:anim forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
