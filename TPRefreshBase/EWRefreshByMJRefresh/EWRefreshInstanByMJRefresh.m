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

@interface EWRefreshInstanByMJRefresh()

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , assign) SEL headerAction;

@property (nonatomic , assign) SEL footerAction;

@property (nonatomic , strong) id refreshManager;

@end

static NSString *const KEWHeaderAction = @"refreshTargetHeader";
static NSString *const KEWFooterAction = @"refreshTargetFooter";


@implementation EWRefreshInstanByMJRefresh

- (instancetype)initWithTarget:(UITableView *)tableView withRefreshManager:(EWBaseRefreshManager *)manager{
    if (self = [super init]) {
        self.refreshManager = manager;
        self.tableView = tableView;
        DiyFooter *footer = [DiyFooter footerWithRefreshingBlock:^{
            [self refreshFooter];
        }];
        self.tableView.mj_footer = footer;
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" //去除警告
        [self.refreshManager performSelector:self.headerAction];
#pragma clang diagnostic pop
    }];
}
/**
 *  刷新底部数据
 */

- (void)refreshFooter{
    self.tableView.mj_footer = [DiyFooter footerWithRefreshingBlock:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks" //去除警告
        [self.refreshManager performSelector:self.footerAction];
#pragma clang diagnostic pop    
    }];
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

- (SEL)headerAction{
    SEL action = NSSelectorFromString(KEWHeaderAction);
    return action;
}

- (SEL)footerAction{
    SEL action = NSSelectorFromString(KEWFooterAction);
    return action;
}
@end
