//
//  ConfirmDestinationViewController.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SleepingViewController.h"
#import "Destination.h"

@interface ConfirmDestinationViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) Destination *selectedLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) SleepingViewController *sleepingVC;
@property (weak, nonatomic) IBOutlet MKMapView *maps;

- (IBAction)btnStartSleeping:(id)sender;

@end
