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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(popVC)];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)popVC
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You are cancling the alarm set to wake you %.1f miles from %@", self.destination.miles, self.destination.destinationName]
                                                    message:@"...Do you want to proceed?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0: //"No" pressed
            //do something?
            break;
        case 1: //"Yes" pressed
            //here you pop the viewController
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [self.center removeAllPendingNotificationRequests];
    UIApplication *application = [UIApplication sharedApplication];
    [application cancelAllLocalNotifications];
}

-(void)viewWillAppear:(BOOL)animated
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You have set an alarm." message: [NSString stringWithFormat:@"The alarm will be triggered %.1f miles from %@.  We highly recomend the use of head phones or earbuds to ensure you wake at the correct time and do not disturb fellow commuters!",self.destination.miles,self.destination.destinationName] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

    
    [self.locationManager startUpdatingLocation];
    UILocalNotification *locNotification = [[UILocalNotification alloc]init];
    locNotification.alertBody = @"Wake up your commute is coming to an end";
    locNotification.region = [[CLCircularRegion alloc]initWithCenter:self.destination.coordinate radius:[self milesSettingInMeters] identifier:@"desty"];
    locNotification.soundName = [NSString stringWithFormat:@"%@",self.destination.ringTone];
    locNotification.regionTriggersOnce = NO;
    UIApplication *application = [UIApplication sharedApplication];
    [application cancelAllLocalNotifications];
    [application scheduleLocalNotification:locNotification];
    
    //alert letting the user know that a geofence has been errected and an alarm will sound when the phone crosses the boarder
    
    
    
    //    [self.locationManager startUpdatingLocation];
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
