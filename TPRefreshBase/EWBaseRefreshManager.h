//
//  EWBaseRefreshManager.h
//  user
//
//  Created by ccpg_it on 17/4/10.
//  Copyright © 2017年 CCPG. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^callBackValue)(id value);
@interface EWBaseRefreshManager : NSObject
//传进来的tableView
@property (nonatomic , strong) UITableView *tableView;

//回调的block
@property (nonatomic , copy) callBackValue callbackValue;

//url
@property (nonatomic , strong) NSString *urlString;

//回调的数据
@property (nonatomic , strong) NSMutableArray *dataArray;

//刷新的页码
@property (nonatomic , assign) NSInteger page;

/**
 * 初始化方法
 */
- (instancetype)initWithTarget:(UITableView *)tableView URLString:(NSString *)urlString callBackValue:(void(^)(id value))callBackValue;

/**
 * 需要重写的方法
 */
- (NSURLSessionDataTask *)refreshTargetHeader;

- (NSURLSessionDataTask *)refreshTargetFooter;

/**
 * 开始刷新,封装了beginRefreshing 和 refreshHeader方法
 */
- (void)refresh;

/**
 *  停止刷新
 */

- (void)endHeaderRefreshing;

- (void)endFooterRefreshing;

/**
 *  开始刷新
 */

- (void)beginRefreshing;

- (void)refreshFooter;

- (void)refreshHeader;

/**
 * 取消请求
 */

- (void)cancellRefresh;

@end
