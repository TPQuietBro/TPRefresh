# TPRefresh
## 新增了代理的方式进行调用,详情请看demo
简单的原理介绍:
通过创建一个基类EWBaseRefreshManager来管理基本的刷新操作.
```
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

- (void)cancellRefresh;
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
@end
```
然后通过产生一个继承类来重写refreshTargetHeader和refreshTargetFooter方法,这两个方法就是外部的网络请求方法,另外取消网络请求的方法cancellRefresh也需要重写,避免网络请求过程中退出当前界面网络请求还在继续的状况.
继承类中的使用方式:
```
#import "TestRefreshManager.h"

@interface TestRefreshManager()
@property (nonatomic , strong) NSURLSessionDataTask *dataTask;
@end

@implementation TestRefreshManager

- (void)cancellRefresh{
    [self.dataTask cancel];
}

- (NSURLSessionDataTask *)refreshTargetHeader{
    [self.dataArray removeAllObjects];
    //测试dataTask为nil,实际情况不为空
    self.dataTask = nil;
    
    for (NSInteger i = 0; i < 5; ++i) {
        [self.dataArray addObject:@(i)];
    }
    if (self.dataArray.count < 5) {
        [self endHeaderRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    self.callbackValue ? self.callbackValue(self.dataArray) : nil;
    [self endHeaderRefreshing];
    return self.dataTask;
}


- (NSURLSessionDataTask *)refreshTargetFooter{
    self.dataTask = nil;
    
    for (NSInteger i = 5; i < 10; ++i) {
        [self.dataArray addObject:@(i)];
    }
    
    self.callbackValue ? self.callbackValue(self.dataArray) : nil;
    [self endFooterRefreshing];
    return self.dataTask;
}

@end
```
外部使用方法<br>
```
/**
 * 生成刷新实例
 */
- (TestRefreshManager *)testRefreshManager{
    if (!_testRefreshManager) {
        WeakSelf
        _testRefreshManager = [[TestRefreshManager alloc] initWithTarget:self.tableView URLString:@"" callBackValue:^(id value) {
            weakSelf.dataArray = value;
            [weakSelf.tableView reloadData];
        }];
    }
    return _testRefreshManager;
}
//调用
- (void)getTestList{
    //开始刷新
    [self.testRefreshManager refresh];
}
