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
#import "WakeUpViewController.h"

@interface SleepingViewController () <LocationManagerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSString *audioPath;

@end

@implementation SleepingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem = backButton;
    // Set up the local notificatin
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions option = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [self.center requestAuthorizationWithOptions:option completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"something went wrong with userNotification");
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [LocationManager sharedInstance].delegate = self;
    [[LocationManager sharedInstance] startUpdatingLocation];
    self.timeJustStarted = YES;
    //setting maxtime to 2.5 hours
    self.maxTime = 60 * 60 * 2.5;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You have set an alarm." message: [NSString stringWithFormat:@"The alarm will be triggered %.1f miles from %@.  We highly recommend the use of head phones or earbuds to ensure you wake at the correct time and do not disturb fellow commuters!",self.destination.miles,self.destination.destinationName] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

    //set audio session
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    NSLog(@"Activating audio session");
    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:&error];
    [audioSession setActive:YES error:&error];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [UIView animateWithDuration:2 delay:0.0 options: (UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
        self.totalView.backgroundColor = [UIColor whiteColor];
        self.totalView.backgroundColor = [UIColor greenColor];
    } completion:nil];

}

-(void) didUpdateLocation:(CLLocation *)location
{
    //creates start time to check if it has been 2.5 hours to turn off location updates
    if(self.timeJustStarted)
    {
        self.startTime = [NSDate date];
        self.timeJustStarted = NO;
    }
    //checks to see if 2.5 hours is up and if it is turns off the location manager to save battery power
    if([self twoAndOneHalfHoursUp])
    {
        [[LocationManager sharedInstance]stopUpdatingLocation];
        self.access = [DAO sharedInstanceOfDAO];
        self.access.commuteTooLong = YES;
        return;
    }
    //checks to see if the user has entered the region they want to wake up at
    double distance = [location distanceFromLocation:[[CLLocation alloc] initWithLatitude:self.destination.coordinate.latitude                                                                        longitude:self.destination.coordinate.longitude]];
    if (distance < [self milesSettingInMeters]) {
        [[LocationManager sharedInstance] stopUpdatingLocation];
        //create alarm trigger content
        self.content = [[UNMutableNotificationContent alloc] init];
        self.content.title = [NSString localizedUserNotificationStringForKey:@"Wake up!" arguments:nil];
        self.content.body = [NSString localizedUserNotificationStringForKey: [NSString stringWithFormat: @"Your stop is coming up in %.1f miles",self.destination.miles] arguments:nil];
        self.trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        //creating the request by adding content and trigger information
        UNNotificationRequest *bussAlarm = [UNNotificationRequest requestWithIdentifier:@"alarm" content:self.content trigger:self.trigger];
        [self.center addNotificationRequest:bussAlarm withCompletionHandler:^(NSError * _Nullable error) {
            if(error){
                NSLog(@"%@",error.localizedDescription);
            }
        }];
        //plays the users requested audio clip to wake them up
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:self.destination.ringTone ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundFileURL error:nil];
        [self.audioPlayer setVolume:30.0];
        [self.audioPlayer play];
        self.access = [DAO sharedInstanceOfDAO];
        self.access.isSleeping = YES;
    }
}

//this method just checks to see 2.5 hours has past since the alarm was created
-(BOOL)twoAndOneHalfHoursUp
{
    NSDate *now = [NSDate date];
    if([now timeIntervalSinceDate:self.startTime] > self.maxTime){
        return YES;
    }else{
        return NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.center removeAllPendingNotificationRequests];
}

//converts the user selected miles into meters that can be used in Apple methods
-(double)milesSettingInMeters
{
    return self.destination.miles*1609.34;
}

- (void)popVC
{
    [[LocationManager sharedInstance]stopUpdatingLocation];
    //shows the alert telling the user they are cancling the alarm becuase they are leaving the sleepingVC
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You are cancling the alarm set to wake you %.1f miles from %@", self.destination.miles, self.destination.destinationName]
                                                    message:@"Do you want to proceed?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

//When yes button is pressed on alert view it sends the user back to the ConfirmDestinationVC
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0:
            break;
        case 1:
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }
}
@end
