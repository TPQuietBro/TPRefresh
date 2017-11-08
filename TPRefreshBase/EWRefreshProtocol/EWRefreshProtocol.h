//
//  EWRefreshProtocol.h
//  TPRefresh
//
//  Created by ccpg_it on 17/4/25.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import <Foundation/Foundation.h>

/*此协议规定了刷新必须实现的方法*/
@class EWBaseRefreshManager;
@protocol EWRefreshProtocol <NSObject>
@required
- (instancetype)initWithTarget:(UIScrollView *)tableView withRefreshManager:(id)manager;

- (void)refresh;

/**
 *  停止刷新
 */
- (void)endHeaderRefreshing;

- (void)endFooterRefreshing;

- (void)endWithNoMoreData;

/**
 *  开始刷新
 */
- (void)beginRefreshing;

- (void)refreshFooter;

- (void)refreshHeader;

@end
