//
//  DeepAIImageCut.m
//  cutTest
//
//  Created by RRTY on 16/9/24.
//  Copyright © 2016年 deepAI. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DeepAIImageCuter.h"

@implementation DeepAIImageCuter
+ (UIImage *)cutImage:(UIImage *)srcImage followPoints:(NSArray *)points {
    NSAssert(srcImage != nil, @"人像植入切图传的srcImage为空");
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:1.0];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [[UIColor clearColor]set];
    
    for (int i = 0; i < points.count; i++) {
        NSValue *point = points[i];
        if (i == 0) {
            [path moveToPoint:point.CGPointValue];
        }
        [path addLineToPoint:point.CGPointValue];
    }
    
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(srcImage.size, NO, 0);
    [path stroke];
    [path addClip];
    [srcImage drawInRect:CGRectMake(0, 0, srcImage.size.width, srcImage.size.height)];
    //获取上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭位图上下文
    UIGraphicsEndImageContext();
    //转成png
    NSData * data = UIImageJPEGRepresentation(image, 1);
    
    return [[UIImage alloc] initWithData:data];
}



@end
