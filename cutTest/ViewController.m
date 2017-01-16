//
//  ViewController.m
//  cutTest
//
//  Created by RRTY on 16/9/24.
//  Copyright © 2016年 deepAI. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewUP;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBottom;
@property (nonatomic,strong) UIImage* image;
@end

@implementation ViewController

- (UIImage *)image {
    if (_image == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test.JPG" ofType:nil];
        _image = [UIImage imageWithContentsOfFile:path];
    }
    return _image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor yellowColor];
    
    PaintView *paintView = [[PaintView alloc] init];
    paintView.frame = self.view.bounds;
    paintView.image = self.image;
    [self.view addSubview:paintView];
}



@end
