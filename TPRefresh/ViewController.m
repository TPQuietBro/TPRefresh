//
//  ViewController.m
//  TPRefresh
//
//  Created by ccpg_it on 17/4/10.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "ViewController.h"
#import "TestRefreshManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//数据源数组
@property (nonatomic , strong) NSMutableArray *dataArray;
//test刷新manager
@property (nonatomic , strong) TestRefreshManager *testRefreshManager;
@end

static NSString *ID = @"testCell";

#define WeakSelf __weak __typeof(self)weakSelf = self;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    //加载列表
    [self getTestList];
}

#pragma mark - tableView delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - API Mehtods

- (void)getTestList{
    //开始刷新
    [self.testRefreshManager refresh];
}

#pragma mark - getter
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

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray= [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
