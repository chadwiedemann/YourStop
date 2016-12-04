//
//  OpeningViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "OpeningViewController.h"
#import "DestinationTableViewController.h"
#import "SetDestinationViewController.h"

@interface OpeningViewController ()

@end

@implementation OpeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DAO *access = [[DAO alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestAlwaysAuthorization];
    
    // Set the navigation bar to color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:46.0/255 green:204.0/255 blue:113.0/255 alpha:1.0];
    
    // Set the navigation item to color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    

    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DAO *access = [DAO sharedInstanceOfDAO];
    if(access.commuteTooLong){
        access.commuteTooLong = NO;
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Time lapsed" message: @"Your commute surpased the maximum allowable commute time.  YourStop has cancled the alarm.  Please only use YourStop for commutes of 2.5 hours or less." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    // Hide the navigation bar in this view controller
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // After this view controller disappear, show the navigation bar again
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSavedLocation:(id)sender {
    // Create the next View controller
    DestinationTableViewController *destinationTableVC = [[DestinationTableViewController alloc]initWithNibName:@"DestinationTableViewController" bundle:nil];
    [self.navigationController pushViewController:destinationTableVC animated:YES];
}

- (IBAction)btnNewLocation:(id)sender {
    
    SetDestinationViewController *setDestinationVC = [[SetDestinationViewController alloc]initWithNibName:@"SetDestinationViewController" bundle:nil];
    
    [self.navigationController pushViewController:setDestinationVC animated:YES];
}
@end
