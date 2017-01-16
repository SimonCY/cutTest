//
//  DeepAIImageCut.h
//  cutTest
//
//  Created by RRTY on 16/9/24.
//  Copyright © 2016年 deepAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeepAIImageCuter : NSObject
+ (UIImage *)cutImage:(UIImage *)srcImage followPoints:(NSArray <NSValue *>*)points;
@end
