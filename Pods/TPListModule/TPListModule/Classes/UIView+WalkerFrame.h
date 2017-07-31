//
//  UIView+WalkerFrame.h
//  TPFrame
//
//  Created by ccpg_it on 17/5/31.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TPFrameExtension.h"

@interface UIView (WalkerFrame)

//距离左边的view的间距
- (void)left_Margin:(CGFloat)left ToView:(UIView *)view;
//距离右边的view的间距
- (void)right_Margin:(CGFloat)right ToView:(UIView *)view;
//距离顶部的view底部的间距
- (void)top_Margin:(CGFloat)top ToView:(UIView *)view;
//距离底部的view的间距
- (void)bottom_Margin:(CGFloat)bottom ToView:(UIView *)view;
//中心对齐
- (void)center_EqualsView:(UIView *)view;
//中心Y对齐
- (void)centerY_EqualsView:(UIView *)view;
//中心X对齐
- (void)centerX_EqualsView:(UIView *)view;
@end
