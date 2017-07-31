//
//  UIView+WalkerFrame.m
//  TPFrame
//
//  Created by ccpg_it on 17/5/31.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "UIView+WalkerFrame.h"

@implementation UIView (WalkerFrame)

//距离左边的view的间距
- (void)left_Margin:(CGFloat)left ToView:(UIView *)view{
    
    CGPoint newPoint = [self newPoint:view];
    
    if ([self isSubView:view]) {
        self.x = left;
        return;
    }
    
    self.x = newPoint.x + view.width + left;
}
//距离右边的view的间距
- (void)right_Margin:(CGFloat)right ToView:(UIView *)view{
    
    CGPoint newPoint = [self newPoint:view];
    
    if ([self isSubView:view]) {
        self.x = view.width - right - self.width;
        return;
    }
    self.x = newPoint.x - right - self.width;
}
//距离顶部的view的间距
- (void)top_Margin:(CGFloat)top ToView:(UIView *)view{

    CGPoint newPoint = [self newPoint:view];
    
    //如果是其子控件
    if ([self isSubView:view]) {
        self.y = top;
        return;
    }
    self.y = newPoint.y + view.height + top;
}

//距离底部的view的间距
- (void)bottom_Margin:(CGFloat)bottom ToView:(UIView *)view{
    //将传入view的point转化成当前view的根父view坐标系
    
    CGPoint newPoint = [self newPoint:view];
    //如果是其子控件
    if ([self isSubView:view]) {
        self.y = view.height - bottom - self.height;
        return;
    }
    self.y = newPoint.y - bottom - self.height;
}

- (void)center_EqualsView:(UIView *)view{
    CGPoint newCenterPoint = [self newCenterPoint:view];
    self.center = newCenterPoint;
}

- (void)centerX_EqualsView:(UIView *)view{
    CGPoint newCenterPoint = [self newCenterPoint:view];
    self.centerX = newCenterPoint.x;
}

- (void)centerY_EqualsView:(UIView *)view{
    CGPoint newCenterPoint = [self newCenterPoint:view];
    self.centerY = newCenterPoint.y;
}


- (CGPoint)newCenterPoint:(UIView *)view{
    
    if (self.superview == nil) {
        NSException *ex = [NSException exceptionWithName:@"no superview" reason:@"please add into superview" userInfo:nil];
        @throw ex;
    }
    if (self.width == 0 || self.height == 0) {
        NSException *ex = [NSException exceptionWithName:@"no height / width" reason:@"please set view size" userInfo:nil];
        @throw ex;
    }
    
    UIView *superView = view.superview ? view.superview : view;
    CGPoint rootViewCenterPoint = [superView convertPoint:view.center toView:self.rootSuperView];
    //再将根父view的位置转为当前view的第一个父view的坐标系
    CGPoint newCenterPoint = [self.rootSuperView convertPoint:rootViewCenterPoint toView:self.superview];
    return newCenterPoint;
}

- (CGPoint)newPoint:(UIView *)view{
    
    if (self.superview == nil) {
        NSException *ex = [NSException exceptionWithName:@"no superview" reason:@"please add into superview" userInfo:nil];
        @throw ex;
    }
    
    CGPoint rootViewPoint = [view convertPoint:view.boundsPoint toView:self.rootSuperView];
    //再将根父view的位置转为当前view的第一个父view的坐标系
    CGPoint newPoint = [self.rootSuperView convertPoint:rootViewPoint toView:self.superview];
    return newPoint;
}

#pragma mark - 判断是不是其子控件
- (BOOL)isSubView:(UIView *)view{
    BOOL isSub = NO;

    for (UIView *subview in view.subviews) {
        if (subview == self) {
            isSub = YES;
            break;
        }
    }
    return isSub;
}

@end
