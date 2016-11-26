//
//  SleepingViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "SleepingViewController.h"

@interface SleepingViewController ()

@end

@implementation SleepingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    [self.center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              NSLog(@"%@",error.localizedDescription);
                          }];
    //create region for alarm trigger
    CLLocationCoordinate2D center = self.destination.coordinate;
    
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center
                                                                 radius:[self milesSettingInMeters]identifier:@"destinationID"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = NO;
    
    
    self.trigger = [UNLocationNotificationTrigger
                                              triggerWithRegion:region repeats:NO];
    
    //create alarm trigger content
    self.content = [[UNMutableNotificationContent alloc] init];
    self.content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
    self.content.body = [NSString localizedUserNotificationStringForKey:@"Wake up time to get off the buss!"
                                                         arguments:nil];
    self.content.sound = [UNNotificationSound soundNamed:self.destination.ringTone];
    NSLog(@"%@",self.destination.ringTone);
    
    UNNotificationRequest *bussAlarm = [UNNotificationRequest requestWithIdentifier:@"alarm" content:self.content trigger:self.trigger];
    
    [self.center addNotificationRequest:bussAlarm withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"add somekind of annimation");
    }];
    [self.locationManager startUpdatingLocation];
    
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)startSleeping
//{
//    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(compareAlarmDistance) userInfo:nil repeats:YES];
//   
//}

- (void)soundTheAlarm
{
   
    NSLog(@"Time to wakkkkkeeee upppp and create the method to ring the phone");
   
    
}

-(double)milesSettingInMeters
{
    return self.destination.miles*1609.34;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    CLLocation *yourDestinationLocation = [[CLLocation alloc]initWithLatitude:self.destination.coordinate.latitude longitude:self.destination.coordinate.longitude];
//    
//    double distanceFromLocationMeters = [self.locationManager.location distanceFromLocation:yourDestinationLocation];
//    
//    if(distanceFromLocationMeters<[self milesSettingInMeters]){
//        
//        
//        
//        UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
//                                                      triggerWithTimeInterval:(1) repeats: NO];
//       
//        UNNotificationRequest *bussAlarm = [UNNotificationRequest requestWithIdentifier:@"alarm" content:self.content trigger:trigger];
//        
//        [self.center addNotificationRequest:bussAlarm withCompletionHandler:^(NSError * _Nullable error) {
//            NSLog(@"play sound to wake");
//        }];
//    
//        [self.locationManager stopUpdatingLocation];
//        
//    }
    
    
    
    
    
}

@end
