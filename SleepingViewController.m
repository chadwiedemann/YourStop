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

-(void)viewDidDisappear:(BOOL)animated
{
    [self.center removeAllPendingNotificationRequests];
}

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
    self.content.badge = [NSNumber numberWithInt:1];
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



@end
