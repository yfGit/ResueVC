//
//  AppDelegate.m
//  ResueVC
//
//  Created by Wolf on 16/2/17.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ResueViewControllerA.h"
#import "ResueViewControllerB.h"
#import "YRootViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    
    MainViewController *vc = [[MainViewController alloc] init];
   
    
    NSArray *identifiers          = @[
                                      @"ResueA",
                                      @"ResueB",
                                      @"ResueA",
                                      @"ResueA",
                                      @"ResueB",
                                      @"ResueB"
                                    ];
    NSDictionary *relationOfVC = @{
                                      @"ResueA":[ResueViewControllerA class],
                                      @"ResueB":[ResueViewControllerB class],
                                      };
    
    /**
     *  注册
     *
     *  @param identifiers  顺序和标识符
     *  @param relationOfVC VC和对应的标识符
     */
    [vc registerIdentifiers:identifiers andViewRelationOfVC:relationOfVC];
    
    // 切换到的页面
    vc.viewControllerDidAppear = ^(YRootViewController *viewController){
        [viewController reloadView];
    };
    
    vc.leftDidAppear = ^(UIViewController *vc) {
      
        NSLog(@"左边越界");
    };
    
    vc.rightDidAppear = ^(UIViewController *vc) {
        
        NSLog(@"右边越界");
    };
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
