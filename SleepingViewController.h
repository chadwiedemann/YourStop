//
//  SleepingViewController.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Destination.h"
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>

@interface SleepingViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) Destination *destination;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property double distanceInMeters;
@property (nonatomic, strong) UNMutableNotificationContent *content;
@property (nonatomic, strong) UNLocationNotificationTrigger *trigger;
@property (nonatomic, strong) UNUserNotificationCenter *center;


@property int checked;
@end
