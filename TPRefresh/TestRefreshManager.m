//
//  TestRefreshManager.m
//  TPRefresh
//
//  Created by ccpg_it on 17/4/10.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "TestRefreshManager.h"

@interface TestRefreshManager()
@property (nonatomic , strong) NSURLSessionDataTask *dataTask;
@end

@implementation TestRefreshManager

- (NSURLSessionDataTask *)refreshTargetHeader{
    [self.dataArray removeAllObjects];
    self.dataTask = nil;
    
    for (NSInteger i = 0; i < 5; ++i) {
        [self.dataArray addObject:@(i)];
    }
    if (self.dataArray.count < 5) {
        [self endHeaderRefreshing];
        [self endWithNoMoreData];
    }

    //block
    self.callbackValue ? self.callbackValue(self.dataArray) : nil;
    
    //delegate
    [self.delegate respondsToSelector:@selector(didRefreshWithCallBackValue:)] ? [self.delegate didRefreshWithCallBackValue:self.dataArray] : nil;
    
    [self endHeaderRefreshing];
    
    return self.dataTask;
}


- (NSURLSessionDataTask *)refreshTargetFooter{
    self.dataTask = nil;
    
    for (NSInteger i = 5; i < 10; ++i) {
        [self.dataArray addObject:@(i)];
    }
    
    //block
    self.callbackValue ? self.callbackValue(self.dataArray) : nil;
    
    //delegate
    [self.delegate respondsToSelector:@selector(didRefreshWithCallBackValue:)] ? [self.delegate didRefreshWithCallBackValue:self.dataArray] : nil;
    
    [self endFooterRefreshing];
    return self.dataTask;
}

@end
