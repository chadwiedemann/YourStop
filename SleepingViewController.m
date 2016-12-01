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

    [LocationManager sharedInstance].delegate = self;
    [[LocationManager sharedInstance] startUpdatingLocation];
    
    // Set up the local notificatin
    self.center = [UNUserNotificationCenter currentNotificationCenter];
    [self.center removeAllPendingNotificationRequests];
    UNAuthorizationOptions option = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [self.center requestAuthorizationWithOptions:option completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"something went wrong with userNotification");
        }
    }];

    //creating shared audiosession
    
    

}

-(void)viewWillAppear:(BOOL)animated
{

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
//        self.totalView.backgroundColor = [UIColor blackColor];
//        self.totalView.backgroundColor = [UIColor greenColor];
//        self.totalView.backgroundColor = [UIColor grayColor];
        self.totalView.backgroundColor = [UIColor whiteColor];
        
//        self.totalView.backgroundColor = [UIColor redColor];

        self.totalView.backgroundColor = [UIColor greenColor];
//        self.totalView.backgroundColor = [UIColor yellowColor];
//        self.totalView.backgroundColor = [UIColor orangeColor];
//         self.totalView.backgroundColor = [UIColor blueColor];
        
    } completion:nil];
    
    
//    self.totalView.animateWithDuration(2, delay: 0.0, options:[UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
//        self.view.backgroundColor = UIColor.blackColor()
//        self.view.backgroundColor = UIColor.greenColor()
//        self.view.backgroundColor = UIColor.grayColor()
//        self.view.backgroundColor = UIColor.redColor()
//    }, completion: nil)
    
    
//    self.totalView.backgroundColor = [UIColor whiteColor];
//    [UIView animateWithDuration:10.0 animations:^{
//        self.totalView.backgroundColor = [UIColor redColor];
//    }];
    
//    self.audioPath = [[NSBundle mainBundle] pathForResource:self.destination.ringTone ofType:@".wav"];
//    NSURL *backGroundSound = [NSURL fileURLWithPath:self.audioPath];
//    NSError *error1;
//    
//    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL: backGroundSound error:&error1];
//    [player setVolume:30.0];
//    [player play];
}

-(void) didUpdateLocation:(CLLocation *)location
{
    double distance = [location distanceFromLocation:[[CLLocation alloc] initWithLatitude:self.destination.coordinate.latitude
                                                                                longitude:self.destination.coordinate.longitude]];
    
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
        
        //create shared audio session
        
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:self.destination.ringTone ofType:@".wav"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundFileURL error:nil];
        [self.audioPlayer setVolume:30.0];
        [self.audioPlayer play];
        
        self.access = [DAO sharedInstanceOfDAO];
        self.access.isSleeping = YES;

        
        
        // Push to Wake up view controller
        WakeUpViewController *wakeUpVc = [[WakeUpViewController alloc]initWithNibName:@"WakeUpViewController" bundle:nil];
        
        [self.navigationController pushViewController:wakeUpVc animated:YES];

    
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

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
//{
//    CLLocation *destinationLocation = [[CLLocation alloc]initWithCoordinate:self.destination.coordinate altitude:0 horizontalAccuracy:1 verticalAccuracy:1 timestamp:[NSDate date]];
//    CLLocationDistance metersToDestination = [self.locationManager.location distanceFromLocation:destinationLocation];
//    
//    if(metersToDestination < [self milesSettingInMeters]){
//        
//        self.timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:(10) repeats:NO];
//        
//        //create content
//        self.content = [[UNMutableNotificationContent alloc] init];
//        self.content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
//        self.content.body = [NSString localizedUserNotificationStringForKey:@"Wake up time to get off the buss!" arguments:nil];
//        self.content.sound = [UNNotificationSound soundNamed:self.destination.ringTone];
//        NSLog(@"%@",self.destination.ringTone);
//        
//        //creating the request by adding content and trigger information
//        UNNotificationRequest *bussAlarm = [UNNotificationRequest requestWithIdentifier:@"alarm" content:self.content trigger:self.timeTrigger];
//        
//        [self.center addNotificationRequest:bussAlarm withCompletionHandler:^(NSError * _Nullable error) {
//            if(error){
//                NSLog(@"%@",error.localizedDescription);
//            }
//            NSLog(@"add somekind of annimation");
//        }];
//    }
//    NSLog(@"distance checked for the %d time",self.checked);
//    self.checked++;
//    self.testingLabel.text = [NSString stringWithFormat:@"%d",self.checked] ;
//}

- (void)popVC
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You are cancling the alarm set to wake you %.1f miles from %@", self.destination.miles, self.destination.destinationName]
                                                    message:@"Do you want to proceed?"
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

@end
