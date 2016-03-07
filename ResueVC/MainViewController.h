//
//  MainViewController.h
//  ResueVC
//
//  Created by Wolf on 16/2/17.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRootViewController;

@interface MainViewController : UIViewController


/** 当前显示的VC */
@property (nonatomic, copy) void(^viewControllerDidAppear)(YRootViewController *viewController);

/** 越界 */
@property (nonatomic, copy) void(^leftDidAppear)(UIViewController *viewController);
@property (nonatomic, copy) void(^rightDidAppear)(UIViewController *viewController);


/**
 *  注册
 *
 *  @param identifiers  顺序和标识符
 *  @param relationOfVC VC和对应的标识符
 */
- (void)registerIdentifiers:(NSArray *)identifiers andViewRelationOfVC:(NSDictionary *)relationOfVC;




@end
