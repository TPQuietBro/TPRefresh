//
//  EWRefreshFactory.h
//  TPRefresh
//
//  Created by ccpg_it on 17/4/25.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EWRefreshProtocol.h"
@interface EWRefreshFactory : NSObject

+ (instancetype)shareInstance;

/*为工厂添加原料*/
- (id)refreshInstanceByTarget:(NSString *)targetClassString tableView:(UIScrollView *)tableView withRefreshManager:(id)manager;

@end
