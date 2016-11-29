//
//  ConfirmDestinationViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "ConfirmDestinationViewController.h"
#import "SleepingViewController.h"

@interface ConfirmDestinationViewController ()

@end

@implementation ConfirmDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up the locationManager
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // set up the pin for the selected location
    CLLocationCoordinate2D coordinates = self.selectedLocation.coordinate;
    
    // Make the annotation for the selected location
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinates, span);
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinates];
    
    [self.maps setRegion:region];
    [self.maps addAnnotation:annotation];
    
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editLocation)];
    
        self.navigationItem.rightBarButtonItem = editButton;
    
    // set up circle
    double meters = self.selectedLocation.miles*1609.34;
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinates radius:meters];
    [self.maps setDelegate:self];
    
    [self.maps addOverlay:circle];
    
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc]initWithCircle:overlay];
    circleRenderer.strokeColor = [UIColor redColor];
    circleRenderer.lineWidth = 1.0;
    
    return circleRenderer;
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

- (IBAction)btnStartSleeping:(id)sender {
    
    SleepingViewController *sleepingVC = [[SleepingViewController alloc]initWithNibName:@"SleepingViewController" bundle:nil];
    sleepingVC.destination = self.selectedLocation;
    [self.navigationController pushViewController:sleepingVC animated:YES];
}

-(void)editLocation
{
    
}


@end
