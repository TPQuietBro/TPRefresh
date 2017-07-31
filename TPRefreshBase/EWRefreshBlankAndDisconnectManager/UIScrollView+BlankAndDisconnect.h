//
//  UIScrollView+BlankAndDisconnect.h
//  TPRefresh
//
//  Created by 魏信洋 on 2017/7/31.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (BlankAndDisconnect)

- (void)addBlankView:(UIView *)blankView withDataArray:(NSArray *)dataArray;

- (void)addWithDisconnectView:(UIView *)disconnectView reloadAction:(SEL)action;

/** 这个方法用来重写的,用来判断是否有网络 **/
- (BOOL)isNetworkOn;


@end
