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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:87.0/255 green:158.0/255 blue:38.0/255 alpha:1.0];
    
    // Set the navigation item to color
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
