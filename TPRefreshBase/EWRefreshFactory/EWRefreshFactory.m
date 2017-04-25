//
//  EWRefreshFactory.m
//  TPRefresh
//
//  Created by ccpg_it on 17/4/25.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "EWRefreshFactory.h"


@implementation EWRefreshFactory

static EWRefreshFactory *singleton = nil;

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (id)refreshInstanceByTarget:(NSString *)targetClassString tableView:(UITableView *)tableView withRefreshManager:(id)manager{
    id<EWRefreshProtocol> refreshInstance = [[NSClassFromString(targetClassString) alloc] initWithTarget:tableView withRefreshManager:manager];

    //如果没有遵守请求的协议就返回nil
    if (![refreshInstance conformsToProtocol:@protocol(EWRefreshProtocol)]) {
        return nil;
    }
    
    return refreshInstance;
}
@end
