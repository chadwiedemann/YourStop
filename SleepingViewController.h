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

@interface SleepingViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) Destination *destination;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property double distanceInMeters;


@end
