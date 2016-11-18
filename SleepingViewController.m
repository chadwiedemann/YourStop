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
    [self startSleeping];
    
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startSleeping
{
    [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(compareAlarmDistance) userInfo:nil repeats:YES];
   
}

- (void)soundTheAlarm
{
   
    NSLog(@"Time to wakkkkkeeee upppp and create the method to ring the phone");
}

-(double)milesSettingInMeters
{
    return self.destination.miles*1609.34;
}

-(void)compareAlarmDistance
{
    CLLocation *destinationLocation = [[CLLocation alloc]initWithCoordinate:self.destination.coordinate altitude:0 horizontalAccuracy:1 verticalAccuracy:1 timestamp:[NSDate date]];
    CLLocationDistance metersToDestination = [self.locationManager.location distanceFromLocation:destinationLocation];

    if(metersToDestination < [self milesSettingInMeters]){
        [self soundTheAlarm];
    }
}

@end
