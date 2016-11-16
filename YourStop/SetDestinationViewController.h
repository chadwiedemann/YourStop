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

@interface SetDestinationViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *setDestinationMapView;
@property (nonatomic, strong) CLLocationManager *locationManager;




@end
