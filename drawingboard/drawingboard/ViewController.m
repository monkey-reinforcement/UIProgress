//
//  ViewController.m
//  drawingboard
//
//  Created by 菊长 on 2019/2/27.
//  Copyright © 2019年 菊长. All rights reserved.
//

#import "ViewController.h"
#import "dbView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet dbView *dbview;


@end

@implementation ViewController
- (IBAction)save:(UIBarButtonItem *)sender {
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.dbview.bounds.size, NO, 0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [self.dbview.layer renderInContext:ref];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
}
- (IBAction)clear:(id)sender {
    [self.dbview clear];
}
- (IBAction)back:(id)sender {
    [self.dbview back];
}
- (IBAction)erase:(id)sender {
    [self.dbview erase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)lineWidthChange:(UISlider *)sender {
    self.dbview.lineWidth = sender.value;
}

- (IBAction)lineColorChange:(UIButton *)sender {
    self.dbview.lineColor = sender.backgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
