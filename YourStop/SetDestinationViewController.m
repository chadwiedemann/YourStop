//
//  SetDestinationViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "SetDestinationViewController.h"

@interface SetDestinationViewController ()

@end

@implementation SetDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if(!self.destinationPin){
//        self.destinationPin = [[Destination alloc]initWithLocation:self.locationManager.location.coordinate];
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.userLocation, 800, 800);
//        [self.setDestinationMapView setRegion:[self.setDestinationMapView regionThatFits:region] animated:YES];
//        [self.setDestinationMapView addAnnotation:self.destinationPin];
//    }
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(moveToSettingsVC)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.setDestinationMapView.showsUserLocation = YES;
    self.userLocation = self.locationManager.location.coordinate;
    self.setDestinationMapView.delegate = self;
    
    // Add Alert View to guide the user to use the pin drop
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Please hold down the pin, then drag and drop it to your destination." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)moveToSettingsVC
{
    SettingsViewController *settingsVC = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
      NSLog(@"hello %f",self.destinationPin.coordinate.latitude);
    settingsVC.editingDestination = self.destinationPin;
    [self.navigationController pushViewController:settingsVC animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    if(!self.destinationPin){
    self.destinationPin = [[Destination alloc]initWithLocation:self.locationManager.location.coordinate];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.userLocation, 800, 800);
        [self.setDestinationMapView setRegion:[self.setDestinationMapView regionThatFits:region] animated:YES];
        [self.setDestinationMapView addAnnotation:self.destinationPin];
    }
    
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
   
}


- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        [annotationView.annotation setCoordinate:droppedAt];
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
    if([annotation isKindOfClass:[Destination class]]){
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ident"];
    pinView.draggable = YES;
    pinView.animatesDrop = YES;
    return pinView;
    }else{
      
        return nil;
        
    }
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *ulv = [mapView viewForAnnotation:mapView.userLocation];
    ulv.hidden = YES;
}

@end
