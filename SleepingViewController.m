//
//  SleepingViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "SleepingViewController.h"
#import "LocationManager.h"
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>

@interface SleepingViewController () <LocationManagerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation SleepingViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [LocationManager sharedInstance].delegate = self;
    [[LocationManager sharedInstance] startUpdatingLocation];
    
    // Set up the local notificatin
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    [self.center removeAllPendingNotificationRequests];
    UNAuthorizationOptions option = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge;
    [self.center requestAuthorizationWithOptions:option completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"something went wrong with userNotification");
        }
    }];


}



-(void) didUpdateLocation:(CLLocation *)location
{
    double distance = [location distanceFromLocation:[[CLLocation alloc] initWithLatitude:self.destination.coordinate.latitude
                                                                                longitude:self.destination.coordinate.longitude]];
    
    if (distance < [self milesSettingInMeters]) {
        [[LocationManager sharedInstance] stopUpdatingLocation];
        NSLog(@"play music here");
        
        //create alarm trigger content
        self.content = [[UNMutableNotificationContent alloc] init];
        self.content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
        self.content.body = [NSString localizedUserNotificationStringForKey:@"Wake up time to get off the buss!" arguments:nil];
//        self.content.badge = [NSNumber numberWithInt:1];
        NSString *soundName = [NSString stringWithFormat:@"%@.wav", self.destination.ringTone];
        
        self.content.sound = [UNNotificationSound soundNamed:soundName];
       
        self.trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        
        //creating the request by adding content and trigger information
        UNNotificationRequest *bussAlarm = [UNNotificationRequest requestWithIdentifier:@"alarm" content:self.content trigger:self.trigger];
        [self.center addNotificationRequest:bussAlarm withCompletionHandler:^(NSError * _Nullable error) {
            if(error){
                NSLog(@"%@",error.localizedDescription);
            }
            NSLog(@"add somekind of annimation");
        }];
        [self.center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
            NSLog(@"WE HAVE A PENDING REQUEST");
            NSLog(@"%@",[requests objectAtIndex:0]);
        }];

    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [self.center removeAllPendingNotificationRequests];
    UIApplication *application = [UIApplication sharedApplication];
    [application cancelAllLocalNotifications];
}

/*

-(void)viewWillAppear:(BOOL)animated
{

    self.center = [UNUserNotificationCenter currentNotificationCenter];
    [self.center removeAllPendingNotificationRequests];
    [self.center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              NSLog(@"%@",error.localizedDescription);
                          }];
    //create region for alarm trigger and location trigger
    CLLocationCoordinate2D center = self.destination.coordinate;
    
    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:center
                                                                 radius:[self milesSettingInMeters]identifier:@"Destination"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = NO;
    self.trigger = [UNLocationNotificationTrigger
                                              triggerWithRegion:region repeats:NO];
    
    //create alarm trigger content
    self.content = [[UNMutableNotificationContent alloc] init];
    self.content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
    self.content.body = [NSString localizedUserNotificationStringForKey:@"Wake up time to get off the buss!" arguments:nil];
    self.content.sound = [UNNotificationSound soundNamed:self.destination.ringTone];
    NSLog(@"%@",self.destination.ringTone);
    
    //creating the request by adding content and trigger information
    UNNotificationRequest *bussAlarm = [UNNotificationRequest requestWithIdentifier:@"alarm" content:self.content trigger:self.trigger];
    
    [self.center addNotificationRequest:bussAlarm withCompletionHandler:^(NSError * _Nullable error) {
        if(error){
        NSLog(@"%@",error.localizedDescription);
        }
        NSLog(@"add somekind of annimation");
    }];
    [self.center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        NSLog(@"WE HAVE A PENDING REQUEST");
        NSLog(@"%@",[requests objectAtIndex:0]);
    }];
    
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

*/

-(double)milesSettingInMeters
{
    return self.destination.miles*1609.34;
}
 

- (void)soundTheAlarm
{
    
    NSLog(@"Time to wakkkkkeeee upppp and create the method to ring the phone");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *destinationLocation = [[CLLocation alloc]initWithCoordinate:self.destination.coordinate altitude:0 horizontalAccuracy:1 verticalAccuracy:1 timestamp:[NSDate date]];
    CLLocationDistance metersToDestination = [self.locationManager.location distanceFromLocation:destinationLocation];
    
    if(metersToDestination < [self milesSettingInMeters]){
        
        self.timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:(10) repeats:NO];
        
        //create content
        self.content = [[UNMutableNotificationContent alloc] init];
        self.content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
        self.content.body = [NSString localizedUserNotificationStringForKey:@"Wake up time to get off the buss!" arguments:nil];
        self.content.sound = [UNNotificationSound soundNamed:self.destination.ringTone];
        NSLog(@"%@",self.destination.ringTone);
        
        //creating the request by adding content and trigger information
        UNNotificationRequest *bussAlarm = [UNNotificationRequest requestWithIdentifier:@"alarm" content:self.content trigger:self.timeTrigger];
        
        [self.center addNotificationRequest:bussAlarm withCompletionHandler:^(NSError * _Nullable error) {
            if(error){
                NSLog(@"%@",error.localizedDescription);
            }
            NSLog(@"add somekind of annimation");
        }];

    }






    NSLog(@"distance checked for the %d time",self.checked);
    self.checked++;
    self.testingLabel.text = [NSString stringWithFormat:@"%d",self.checked] ;
}


@end
