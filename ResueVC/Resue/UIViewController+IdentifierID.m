//
//  UIViewController+IdentifierID.m
//  ResueVC
//
//  Created by Wolf on 16/2/17.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "UIViewController+IdentifierID.h"
#import <objc/runtime.h>

@implementation UIViewController (IdentifierID)


- (void)setYIdentifierID:(NSString *)yIdentifierID
{
    objc_setAssociatedObject(self, @selector(yIdentifierID), yIdentifierID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)yIdentifierID
{
    return objc_getAssociatedObject(self, _cmd);
}




- (void)setYPage:(NSNumber *)yPage
{
    objc_setAssociatedObject(self, @selector(yPage), yPage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)yPage
{
   return objc_getAssociatedObject(self, _cmd);
}

@end
