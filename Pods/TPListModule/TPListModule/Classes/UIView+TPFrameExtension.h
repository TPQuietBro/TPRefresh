//
//  UIView+TPFrameExtension.h
//
//  Created by 唐鹏 on 16/5/29.
//  Copyright © 2016年 tangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TPFrameExtension)

/**width*/
@property (nonatomic,assign) CGFloat width;

/**height*/
@property (nonatomic,assign) CGFloat height;

/**x*/
@property (nonatomic,assign) CGFloat x;

/**y*/
@property (nonatomic,assign) CGFloat y;

/**size*/
@property (nonatomic,assign) CGSize size;

/**point*/
@property (nonatomic,assign) CGPoint point;

@property (nonatomic , assign) CGPoint boundsPoint;

/**
 *  centerX
 */
@property (nonatomic,assign) CGFloat centerX;

/**centerY*/
@property (nonatomic,assign) CGFloat centerY;

@property (nonatomic , strong) UIView *rootSuperView;


@end
