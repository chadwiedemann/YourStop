//
//  AppDelegate.m
//  YourStop
//
//  Created by Chad Wiedemann on 10/31/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "OpeningViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Set the root view controller
    UIViewController *rootController = [[OpeningViewController alloc]initWithNibName:@"OpeningViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:rootController];
    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //checks status on alarm and instucts the app to implement the appropriate procedure
    DAO *access = [DAO sharedInstanceOfDAO];
    if(access.isSleeping)
    {
        access.isSleeping = NO;
        WakeUpViewController *wakeUpVc = [[WakeUpViewController alloc]initWithNibName:@"WakeUpViewController" bundle:nil];
        [self.navigationController pushViewController:wakeUpVc animated:YES];
    }else if (access.commuteTooLong){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
   DAO *access =  [DAO sharedInstanceOfDAO];
    [access saveContext];
}



@end
