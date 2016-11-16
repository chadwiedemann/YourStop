//
//  AppDelegate.h
//  YourStop
//
//  Created by Chad Wiedemann on 10/31/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

