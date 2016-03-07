//
//  UIViewController+IdentifierID.h
//  ResueVC
//
//  Created by Wolf on 16/2/17.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (IdentifierID)

/** 同TableViewCell的identifier*/
@property (nonatomic, copy) NSString *yIdentifierID;

/** 同TableViewCell的indexPath*/
@property (nonatomic, assign) NSNumber *yPage;

@end
