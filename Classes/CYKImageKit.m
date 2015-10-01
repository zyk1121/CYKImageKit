//
//  CYKImageKit.m
//  Pods
//
//  Created by zhangyuanke on 15/10/1.
//
//

#import "CYKImageKit.h"
#import "CYKMacros.h"

@implementation CYKImageKit

+ (UIImage *)watermarkImageWithImage:(UIImage *)srcImage andLogoText:(NSString *)logoText
{
    // 如果原图为nil，返回nil
    if (!srcImage) {
        return nil;
    }
    // 如果logoText为nil或“”，返回原图
    if ([logoText length] <= 0) {
        return srcImage;
    }
    
    // 设置上下文（画布）大小
    CGSize imgSize = CGSizeMake(srcImage.size.width, srcImage.size.height);
    // 创建一个基于位图的上下文(context)，并将其设置为当前上下文
    UIGraphicsBeginImageContext(imgSize);
    // 获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 在绘制到context前通过矩阵垂直翻转坐标系
    CGContextTranslateCTM(contextRef, 0, srcImage.size.height);
    // 画布翻转
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    // 在上下文种画当前图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, srcImage.size.width, srcImage.size.height), [srcImage CGImage]);
    if(kCYKIOSVersion >= 7.0)
    {
        // 上下文种的文字属性
        [[UIColor grayColor] set];
        CGContextTranslateCTM(contextRef, srcImage.size.width/12, srcImage.size.height/5);//
        CGContextScaleCTM(contextRef, 1.0, -1.0);    // 缩放
        CGContextRotateCTM(contextRef, -30*M_PI/180);        // 旋转
        CGContextSetAlpha(contextRef, 0.3);         // 透明度
        
        // 字体大小
        int fontSize = imgSize.height / [logoText length];
        
        fontSize += 2;
        
        NSDictionary* logoDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize], NSFontAttributeName, nil];
        // 绘制文字
        [logoText drawAtPoint:CGPointMake(0, 0) withAttributes:logoDic];
        CGContextRotateCTM(contextRef, 30*M_PI/180);        // 旋转
        CGContextTranslateCTM(contextRef, 0, -(srcImage.size.height/3));
        CGContextRotateCTM(contextRef, -30*M_PI/180);        // -旋转
        [logoText drawAtPoint:CGPointMake(0, 0) withAttributes:logoDic];
    }
    
    // 从当前上下文种获取图片
    UIImage *retImg =UIGraphicsGetImageFromCurrentImageContext();
    // 移除栈顶的基于当前位图的图形上下文
    UIGraphicsEndImageContext();
    
    return retImg;
}

@end
