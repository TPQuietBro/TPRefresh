//
//  EWRefreshInstanByMJRefresh.m
//  TPRefresh
//
//  Created by ccpg_it on 17/4/25.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "EWRefreshInstanByMJRefresh.h"
#import "DiyFooter.h"
#import "DiyHeader.h"
#import <MJRefresh.h>
#import "EWChildRefreshProtocol.h"
@interface EWRefreshInstanByMJRefresh()

@property (nonatomic , strong) UIScrollView *tableView;

@property (nonatomic , assign) SEL headerAction;

@property (nonatomic , assign) SEL footerAction;

@property (nonatomic , strong) id refreshManager;

@property (nonatomic,strong) DiyFooter *footer;

@end

static NSString *const KEWHeaderAction = @"refreshTargetHeader";
static NSString *const KEWFooterAction = @"refreshTargetFooter";
#define WeakSelf __weak __typeof(self)weakSelf = self;

@implementation EWRefreshInstanByMJRefresh

- (instancetype)initWithTarget:(UIScrollView *)tableView withRefreshManager:(id)manager{
    if (self = [super init]) {
        self.refreshManager = manager;
        self.tableView = tableView;
        self.tableView.mj_footer = self.footer;
    }
    return self;
}

- (void)refresh{
    [self refreshHeader];
    [self beginRefreshing];
}
/**
 *  刷新头部数据
 */

- (void)refreshHeader{
    if ([self.tableView.mj_header isRefreshing]) {
        self.tableView.userInteractionEnabled = NO;
    }else{
        self.tableView.userInteractionEnabled = YES;
    }
    self.tableView.mj_header = [DiyHeader headerWithRefreshingBlock:^{
        WeakSelf
        if ([self.refreshManager respondsToSelector:@selector(refreshTargetHeader)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" //去除警告
        [weakSelf.refreshManager performSelector:weakSelf.headerAction];
#pragma clang diagnostic pop
        }
    }];
}
/**
 *  刷新底部数据
 */

- (void)refreshFooter{
    if ([self.refreshManager respondsToSelector:@selector(refreshTargetFooter)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" //去除警告
        [self.refreshManager performSelector:self.footerAction];
#pragma clang diagnostic pop
    }
}

/**
 *  停止刷新
 */

- (void)endHeaderRefreshing{
    [self.tableView.mj_header endRefreshing];
}

- (void)endFooterRefreshing{
    [self.tableView.mj_footer endRefreshing];
}

- (void)endWithNoMoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

/**
 *  开始刷新
 */

- (void)beginRefreshing{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - getter

- (DiyFooter *)footer{
    if (!_footer) {
        _footer = [DiyFooter footerWithRefreshingBlock:^{
            WeakSelf
            [weakSelf refreshFooter];
        }];
    }
    return _footer;
}

- (SEL)headerAction{
    SEL action = NSSelectorFromString(KEWHeaderAction);
    return action;
}

- (SEL)footerAction{
    SEL action = NSSelectorFromString(KEWFooterAction);
    return action;
}
@end
