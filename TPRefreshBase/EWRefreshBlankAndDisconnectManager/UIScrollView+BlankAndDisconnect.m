//
//  UIScrollView+BlankAndDisconnect.m
//  TPRefresh
//
//  Created by 魏信洋 on 2017/7/31.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "UIScrollView+BlankAndDisconnect.h"
#import <objc/message.h>

@implementation UIScrollView (BlankAndDisconnect)

- (void)addBlankView:(UIView *)blankView withDataArray:(NSArray *)dataArray{

    [self judgeDataArray:dataArray view:blankView];
}

- (void)addWithDisconnectView:(UIView *)disconnectView reloadAction:(SEL)action{
    [self judgeDisconnectView:disconnectView];
}

- (void)judgeDataArray:(NSArray *)dataArray view:(UIView *)blankView{
    if (dataArray.count == 0 && blankView) {
        blankView.frame = self.bounds;
        [self addSubview:blankView];
    }else{
        [blankView removeFromSuperview];
    }
}

- (void)judgeDisconnectView:(UIView *)disconnectView{
    if (![self isNetworkOn] && disconnectView) {
        disconnectView.frame = self.bounds;
        [self addSubview:disconnectView];
    }else{
        [disconnectView removeFromSuperview];
    }
}

- (void)reload{
    if ([self isKindOfClass:[UITableView class]]) {
       ((void(*)(id,SEL))objc_msgSend)(self,@selector(reloadData));
    }else{
        
    }
}

//default network on,need Override
- (BOOL)isNetworkOn{
    return YES;
}

@end
