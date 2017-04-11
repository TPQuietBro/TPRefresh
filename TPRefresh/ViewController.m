//
//  ViewController.m
//  TPRefresh
//
//  Created by ccpg_it on 17/4/10.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "ViewController.h"
#import "TestRefreshManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,EWBaseRefreshManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//数据源数组
@property (nonatomic , strong) NSMutableArray *dataArray;
//刷新的manager by block
@property (nonatomic , strong) TestRefreshManager *testRefreshManagerByBlock;
//by delegate
@property (nonatomic , strong) TestRefreshManager *testRefreshManagerByDelegate;
@end

static NSString *ID = @"testCell";

#define WeakSelf __weak __typeof(self)weakSelf = self;
@implementation ViewController

#pragma mark - life cycle
/**
 * 退出的时候取消进行中的请求
 */
- (void)dealloc{
    
    [self.testRefreshManagerByDelegate cancellRefresh];
    
    [self.testRefreshManagerByBlock cancellRefresh];
}

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

#pragma mark - custom delegate方式进行刷新

- (void)didRefreshWithCallBackValue:(id)value{
    self.dataArray = value;
    [self.tableView reloadData];
}

#pragma mark - API Mehtods

- (void)getTestList{
    //开始刷新
    
    //block方式
    //[self.testRefreshManagerByBlock refresh];
    
    //delegate方式
    [self.testRefreshManagerByDelegate refresh];
}

#pragma mark - getter
/**
 * 生成刷新实例block方式
 */
- (TestRefreshManager *)testRefreshManagerByBlock{
    if (!_testRefreshManagerByBlock) {
        WeakSelf
        _testRefreshManagerByBlock = [[TestRefreshManager alloc] initWithTarget:self.tableView requestParams:@{@"url" : @"http://fdsafd",@"params" : @{@"name" : @"allen"}} callBackValue:^(id value) {
            weakSelf.dataArray = value;
            [weakSelf.tableView reloadData];
        }];
    }
    return _testRefreshManagerByBlock;
}
/**
 * 生成刷新实例delegate方式
 */
- (TestRefreshManager *)testRefreshManagerByDelegate{
    if (!_testRefreshManagerByDelegate) {
        _testRefreshManagerByDelegate = [[TestRefreshManager alloc] initWithTarget:self.tableView requestParams:@{@"url" : @"http://fdsafd",@"params" : @{@"name" : @"allen"}} callBackValue:nil];
        _testRefreshManagerByDelegate.delegate = self;
    }
    return _testRefreshManagerByDelegate;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray= [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
