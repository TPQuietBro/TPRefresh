//
//  EWBaseRefreshManager.h
//  user
//
//  Created by ccpg_it on 17/4/10.
//  Copyright © 2017年 CCPG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EWChildRefreshProtocol.h"
typedef void(^callBackValue)(id value);

@protocol EWBaseRefreshManagerDelegate <NSObject>

- (void)didRefreshWithCallBackValue:(id)value;

- (void)didRefreshWithFailedCallBackValue:(id)value;

@end

@interface EWBaseRefreshManager : NSObject
//传进来的View
@property (nonatomic , strong) UIScrollView* tableView;

//回调的block
@property (nonatomic , copy) callBackValue callbackValue;

//传入的参数字典,包含url和请求参数,具体key值自定义即可
@property (nonatomic , strong) NSDictionary *requestParams;

//回调的数据
@property (nonatomic , strong) NSMutableArray *dataArray;

//刷新的页码
@property (nonatomic , assign) NSInteger page;

@property (nonatomic , weak) id<EWBaseRefreshManagerDelegate> delegate;

@property (nonatomic , weak) id<EWChildRefreshProtocol> childManager;

@property (nonatomic , strong) NSError *error;

/**
 * 初始化方法
 */
- (instancetype)initWithTarget:(id)tableView requestParams:(NSDictionary *)requestParams callBackValue:(void(^)(id value))callBackValue;

/**
 * 开始刷新,封装了beginRefreshing 和 refreshHeader方法
 */
- (void)refresh;

/**
 * 回调数据的方法
 */
- (void)callBackData;

- (void)callBackFailed;

/**
 *  停止刷新
 */

- (void)endHeaderRefreshing;

- (void)endFooterRefreshing;

- (void)endWithNoMoreData;

/**
 * 取消请求
 */

- (void)cancellRefresh;

@end
