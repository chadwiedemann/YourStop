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


@interface SleepingViewController : UIViewController <CLLocationManagerDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *testingLabel;
@property (nonatomic, strong) Destination *destination;
@property double distanceInMeters;
@property (nonatomic, strong) UNMutableNotificationContent *content;
@property (nonatomic, strong) UNTimeIntervalNotificationTrigger *trigger;
@property (nonatomic, strong) UNUserNotificationCenter *center;
@property (nonatomic, strong) UNTimeIntervalNotificationTrigger *timeTrigger;
@property (nonatomic, strong) CLLocationManager *locationManager;

//uilocalnotification section


@property int checked;

@end
