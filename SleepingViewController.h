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
#import <CoreLocation/CoreLocation.h>
#import "DAO.h"


@interface SleepingViewController : UIViewController <CLLocationManagerDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *totalView;
@property (nonatomic, strong) Destination *destination;
@property (nonatomic, strong) UNMutableNotificationContent *content;
@property (nonatomic, strong) UNTimeIntervalNotificationTrigger *trigger;
@property (nonatomic, strong) UNUserNotificationCenter *center;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) DAO *access;
@property (nonatomic, strong) NSDate *startTime;
@property NSTimeInterval maxTime;
@property BOOL timeJustStarted;

@end
