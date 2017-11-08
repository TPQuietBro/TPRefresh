//
//  EWRefreshFactory.m
//  TPRefresh
//
//  Created by ccpg_it on 17/4/25.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "EWRefreshFactory.h"
#import "EWChildRefreshProtocol.h"

@implementation EWRefreshFactory

static EWRefreshFactory *singleton = nil;

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}
/**
 * 返回的是一个三方库的实例对象,必须遵守对应协议
 */
- (id)refreshInstanceByTarget:(NSString *)targetClassString tableView:(UIScrollView *)tableView withRefreshManager:(id<EWChildRefreshProtocol>)manager{
    id<EWRefreshProtocol> refreshInstance = [[NSClassFromString(targetClassString) alloc] initWithTarget:tableView withRefreshManager:manager];

    //如果没有遵守请求的协议就返回nil
    if (![refreshInstance conformsToProtocol:@protocol(EWRefreshProtocol)]) {
        return nil;
    }
    
    return refreshInstance;
}
@end
