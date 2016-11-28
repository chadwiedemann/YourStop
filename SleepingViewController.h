//
//  SleepingViewController.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Destination.h"
#import <UserNotifications/UserNotifications.h>

@interface SleepingViewController : UIViewController

@property (nonatomic, strong) Destination *destination;
@property double distanceInMeters;
@property (nonatomic, strong) UNMutableNotificationContent *content;
@property (nonatomic, strong) UNLocationNotificationTrigger *trigger;
@property (nonatomic, strong) UNUserNotificationCenter *center;
@end
