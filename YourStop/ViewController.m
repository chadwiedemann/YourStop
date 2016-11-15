//
//  ViewController.m
//  YourStop
//
//  Created by Chad Wiedemann on 10/31/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    self.mapView.userTrackingMode = YES;
    /*self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLLocationAccuracyKilometer;
    
    CLLocation *location = [self.locationManager location];
    
    coordinate = [location coordinate];
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
    */
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
