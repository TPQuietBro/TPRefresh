//
//  DiyFooter.m
//  user
//
//  Created by zhengrui on 16/10/18.
//  Copyright © 2016年 CCPG. All rights reserved.
//

#import "DiyFooter.h"
@implementation DiyFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    
    // 隐藏状态
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"玩命加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"" forState:MJRefreshStateNoMoreData];
}



@end
