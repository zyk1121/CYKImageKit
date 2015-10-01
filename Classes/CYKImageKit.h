//
//  CYKImageKit.h
//  Pods
//
//  Created by zhangyuanke on 15/10/1.
//
//  CYKImageKit是一个简单的图像处理工具类
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CYKImageKit : NSObject

// 给图像添加文字水印
+ (UIImage *)watermarkImageWithImage:(UIImage *)srcImage andLogoText:(NSString *)logoText;

@end
