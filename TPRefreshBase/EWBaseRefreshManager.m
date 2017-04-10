//
//  EWBaseRefreshManager.m
//  user
//
//  Created by ccpg_it on 17/4/10.
//  Copyright © 2017年 CCPG. All rights reserved.
//

#import "EWBaseRefreshManager.h"
#import "DiyFooter.h"
#import "DiyHeader.h"

@implementation EWBaseRefreshManager
- (instancetype)initWithTarget:(UITableView *)tableView URLString:(NSString *)urlString callBackValue:(void (^)(id))callBackValue{
    self = [super init];
    if (self) {
        self.urlString = urlString;
        self.tableView = tableView;
        self.callbackValue = callBackValue;
        DiyFooter *footer = [DiyFooter footerWithRefreshingBlock:^{
            [self refreshFooter];
        }];
        
        self.tableView.mj_footer = footer;
    }
    return self;
}
#pragma mark - 子类重写这个两个方法完成上拉下拉刷新
- (NSURLSessionDataTask *)refreshTargetHeader{
    return nil;
}

- (NSURLSessionDataTask *)refreshTargetFooter{
    return nil;
}

- (void)cancellRefresh{
    
}

#pragma mark - refresh methods

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
        [self refreshTargetHeader];
    }];
    
}
/**
 *  刷新底部数据
 */

- (void)refreshFooter{
    self.tableView.mj_footer = [DiyFooter footerWithRefreshingBlock:^{
        [self refreshTargetFooter];
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

/**
 *  开始刷新
 */

- (void)beginRefreshing{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - getter

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end