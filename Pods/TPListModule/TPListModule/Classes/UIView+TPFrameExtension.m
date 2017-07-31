//
//  UIView+TPFrameExtension.m
//
//  Created by 唐鹏 on 16/5/29.
//  Copyright © 2016年 tangpeng. All rights reserved.
//

#import "UIView+TPFrameExtension.h"

@implementation UIView (TPFrameExtension)

-(void)setWidth:(CGFloat)width{

    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setX:(CGFloat)x{

    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint center  = self.center;
    center.x = centerX;
    self.center = center;
}
-(void)setCenterY:(CGFloat)centerY{
    
    CGPoint center  = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerX{

    return self.center.x;
}
-(CGFloat)centerY{

    return self.center.y;
}

-(void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(void)setSize:(CGSize)size{

    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(void)setPoint:(CGPoint)point{
    
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

- (CGPoint)point{
    return self.frame.origin;
}

- (void)setBoundsPoint:(CGPoint)boundsPoint{
    CGRect bounds = self.bounds;
    bounds.origin = boundsPoint;
    self.bounds = bounds;
}

- (CGPoint)boundsPoint{
    return self.bounds.origin;
}

-(CGSize)size{

    return self.frame.size;
}
-(CGFloat)width{

    return self.frame.size.width;
}
-(CGFloat)height{
    
    return self.frame.size.height;
}

-(CGFloat)x{
        
        return self.frame.origin.x;
}

-(CGFloat)y{
    
    return self.frame.origin.y;
}

- (UIView *)rootSuperView{
    UIView *walkerSuperView1 = self.superview;
    //如果没有父类
    if (walkerSuperView1 == nil) {
        walkerSuperView1 = self;
    }else{
        //递归遍历到父类
        while (walkerSuperView1.superview) {
            walkerSuperView1 = walkerSuperView1.superview;
        }
    }
    return walkerSuperView1;
}

- (void)setRootSuperView:(UIView *)rootSuperView{
    
}

@end
