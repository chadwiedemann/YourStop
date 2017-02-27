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
    self.searchBar.delegate = self;
    self.setDestinationMapView.showsUserLocation = YES;
    self.userLocation = self.locationManager.location.coordinate;
    self.setDestinationMapView.delegate = self;
    
    // Add Alert View to guide the user to use the pin drop
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Set destination" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    if(!self.destinationPin){
    self.destinationPin = [[Destination alloc]initWithLocation:self.locationManager.location.coordinate];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.userLocation, 800, 800);
        [self.setDestinationMapView setRegion:[self.setDestinationMapView regionThatFits:region] animated:YES];
//        [self.setDestinationMapView addAnnotation:self.destinationPin];
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

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    self.destinationPin.coordinate = mapView.centerCoordinate;
    NSLog(@"screen moved and new latitude is %f", mapView.centerCoordinate.latitude);
    if (mapChangedFromUserInteraction) {
        // user changed map region
        self.doneButton.hidden = NO;
    }
}

- (IBAction)doneButtonAction:(id)sender {
    SettingsViewController *settingsVC = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    NSLog(@"hello %f",self.destinationPin.coordinate.latitude);
    settingsVC.editingDestination = self.destinationPin;
    [self.navigationController pushViewController:settingsVC animated:YES];
}

//making the done button disapear when the map is moving

- (BOOL)mapViewRegionDidChangeFromUserInteraction
{
    UIView *view = self.setDestinationMapView.subviews.firstObject;
    //  Look through gesture recognizers to determine whether this region change is from user interaction
    for(UIGestureRecognizer *recognizer in view.gestureRecognizers) {
        if(recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateEnded) {
            return YES;
        }
    }
    
    return NO;
}

static BOOL mapChangedFromUserInteraction = NO;

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    mapChangedFromUserInteraction = [self mapViewRegionDidChangeFromUserInteraction];
    
    if (mapChangedFromUserInteraction) {
        self.doneButton.hidden = YES;
    }
}


@end
