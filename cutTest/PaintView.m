//
//  PaintView.m
//  cutTest
//
//  Created by RRTY on 16/9/24.
//  Copyright © 2016年 deepAI. All rights reserved.
//

#import "PaintView.h"

@interface PaintView ()
@property (nonatomic,strong) NSMutableArray* points;
@property (nonatomic,strong) UIBezierPath* path;
@end

@implementation PaintView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [self.image drawInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    [self.path setLineWidth:2.0];
    [self.path setLineJoinStyle:kCGLineJoinRound];
    [self.path setLineCapStyle:kCGLineCapRound];
    [[UIColor redColor]set];

    
    [self.path stroke];

}

- (void)test{
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor clearColor] set];
    [self.path stroke];
    [self.path addClip];
    [self.image drawInRect:self.bounds];
    //获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭位图上下文
    UIGraphicsEndImageContext();
//    [self saveImageInDocument:image atPath:@"/Users/rrty/Desktop/未命名文件夹" asName:@"/result.jpg"];
//    
//    NSData * data = UIImageJPEGRepresentation(image, 1);

    
    UIImageView *aa = [[UIImageView alloc] initWithImage:image];
    aa.backgroundColor = [UIColor redColor];
    aa.frame = self.bounds;
    [self.window addSubview:aa];
    
    
//    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], nil, nil, nil);
}



//path与filename都需要以/开始,例如/images与/result.jpg
- (void) saveImageInDocument:(UIImage *) image atPath:(NSString *)path asName:(NSString *) filename{
    //表示
    NSData *data = nil;
    data = UIImagePNGRepresentation(image);
    if (data == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    }
    //获取document目录
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingString: filename];
    //
//    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
//    NSString *fullPath = [filePath stringByAppendingString: filename];
    NSLog(@"full path: %@", filePath);
    //
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
}








-(void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:point];
    [self.path addLineToPoint:point];
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    [self.path addLineToPoint:point];
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
    [self.path closePath];
    [self test];
    [self setNeedsDisplay];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [self touchesMoved:touches withEvent:event];
}
@end
