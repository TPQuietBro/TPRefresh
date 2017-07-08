//
//  EWChildRefreshProtocol.h
//  TPRefresh
//
//  Created by ccpg_it on 17/4/25.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EWChildRefreshProtocol <NSObject>

@required
#pragma mark - 子类实现这个两个方法完成上拉下拉刷新
- (NSURLSessionDataTask *)refreshTargetHeader;

- (NSURLSessionDataTask *)refreshTargetFooter;

@end
