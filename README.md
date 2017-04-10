# TPRefresh
使用方法<br>
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
