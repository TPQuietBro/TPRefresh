//
//  EWBaseRefreshManager.m
//  user
//
//  Created by ccpg_it on 17/4/10.
//  Copyright © 2017年 CCPG. All rights reserved.
//

#import "EWBaseRefreshManager.h"
#import "EWRefreshFactory.h"


@interface EWBaseRefreshManager()

@property (nonatomic , strong) NSURLSessionTask *dataTaskHeader;

@property (nonatomic , strong) NSURLSessionTask *dataTaskFooter;

@property (nonatomic , strong) id<EWRefreshProtocol> refreshInstance;

@end

static NSString * const KRefreshByMJ = @"EWRefreshInstanByMJRefresh";



@implementation EWBaseRefreshManager
- (instancetype)initWithTarget:(id)tableView requestParams:(NSDictionary *)requestParams callBackValue:(void(^)(id value))callBackValue{
    self = [super init];
    if (self) {
        self.requestParams = requestParams;
        self.tableView = tableView;
        self.callbackValue = callBackValue;

        //这句代码的作用取得子类的实例
        if ([self conformsToProtocol:@protocol(EWChildRefreshProtocol)]) {
            self.childManager = (id<EWChildRefreshProtocol>)self;
        }
    }
    return self;
}

/**
 * 取消请求
 */
- (void)cancellRefresh{
    self.dataTaskHeader = [self.childManager refreshTargetHeader];
    if (self.dataTaskHeader) {
        [self.dataTaskHeader cancel];
    }
    self.dataTaskFooter = [self.childManager refreshTargetFooter];
    
    if (self.dataTaskFooter) {
        [self.dataTaskFooter cancel];
    }
    
    self.dataTaskHeader = nil;
    self.dataTaskFooter = nil;
}

#pragma mark - refresh methods
/**
 * 刷新方法
 */
- (void)refresh{
    
    [self.refreshInstance refresh];

}
/**
 * 统一回调数据
 */
- (void)callBackData{
   
    self.callbackValue ? self.callbackValue(self.dataArray) : nil;
    [self.delegate respondsToSelector:@selector(didRefreshWithCallBackValue:)] ? [self.delegate didRefreshWithCallBackValue:self.dataArray] : nil;
    
}

- (void)callBackFailed{
    [self.delegate respondsToSelector:@selector(didRefreshWithFailedCallBackValue:)] ? [self.delegate didRefreshWithFailedCallBackValue:self.error] : nil;
}

/**
 *  停止刷新
 */

- (void)endHeaderRefreshing{
    [self.refreshInstance endHeaderRefreshing];
}

- (void)endFooterRefreshing{
    [self.refreshInstance endFooterRefreshing];
}
/**
 * 根据条件是否进行底部上拉刷新,例如数据少于10条就不刷新
 */
- (void)endWithNoMoreData{
    [self.refreshInstance endWithNoMoreData];
}

#pragma mark - getter
/**
 * 工厂方法获取刷新实例
 */
- (id<EWRefreshProtocol>)refreshInstance{
    if (!_refreshInstance) {
        _refreshInstance = [[EWRefreshFactory shareInstance] refreshInstanceByTarget:KRefreshByMJ tableView:self.tableView withRefreshManager:self.childManager];
    }
    return _refreshInstance;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end
