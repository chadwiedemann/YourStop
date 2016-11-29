//
//  LocationManager.m
//  YourStop
//
//  Created by chutima mungmee on 11/28/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "LocationManager.h"
@import CoreLocation;

@interface LocationManager () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *lastTimestamp;

@end


@implementation LocationManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        LocationManager *instance = sharedInstance;
        instance.locationManager = [CLLocationManager new];
        instance.locationManager.delegate = instance;
        instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // you can use kCLLocationAccuracyHundredMeters to get better battery life
        instance.locationManager.pausesLocationUpdatesAutomatically = NO; // this is important
    });
    
    return sharedInstance;
}

-(void) stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

- (void)startUpdatingLocation
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusDenied)
    {
        NSLog(@"Location services are disabled in settings.");
    }
    else
    {
        // for iOS 8
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [self.locationManager requestAlwaysAuthorization];
        }
        // for iOS 9
        if ([self.locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)])
        {
            [self.locationManager setAllowsBackgroundLocationUpdates:YES];
        }
        
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *mostRecentLocation = locations.lastObject;
    NSLog(@"Current location: %@ %@", @(mostRecentLocation.coordinate.latitude), @(mostRecentLocation.coordinate.longitude));
    
    NSDate *now = [NSDate date];
//    NSTimeInterval interval = self.lastTimestamp ? [now timeIntervalSinceDate:self.lastTimestamp] : 0;

    NSTimeInterval interval = 0;
    if (self.lastTimestamp) {
        interval = [now timeIntervalSinceDate:self.lastTimestamp];
    } else {
        interval = 0;
    }
    
    if (!self.lastTimestamp || interval >= 1 * 10)
    {
        self.lastTimestamp = now;
        //NSLog(@"Sending current location to web service.");
        
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(didUpdateLocation:)]) {
                [self.delegate didUpdateLocation:mostRecentLocation];
            }
        }
        
    }
}

@end
