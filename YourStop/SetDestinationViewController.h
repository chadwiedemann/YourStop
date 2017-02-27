//
//  SetDestinationViewController.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Destination.h"
#import "SettingsViewController.h"
#import "IgnoreView.h"

@interface SetDestinationViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UIScrollViewDelegate>
- (IBAction)doneButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet MKMapView *setDestinationMapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Destination *destinationPin;
@property CLLocationCoordinate2D userLocation;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
