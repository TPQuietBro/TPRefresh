//
//  DiyHeader.m
//  user
//
//  Created by zhengrui on 16/10/17.
//  Copyright © 2016年 CCPG. All rights reserved.
//

#import "DiyHeader.h"
@implementation DiyHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    CGSize size = [UIImage imageNamed:@"00"].size;
    self.mj_h = size.height+Height(40);

    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i < 13; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"0%lu", (unsigned long)i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i < 13; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"0%lu", (unsigned long)i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    self.stateLabel.hidden = NO;
    
   
    
}


@end
