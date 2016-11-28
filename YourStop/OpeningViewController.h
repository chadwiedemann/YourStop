//
//  OpeningViewController.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface OpeningViewController : UIViewController <CLLocationManagerDelegate>

//- (IBAction)startAppBtnPressed:(id)sender;

- (IBAction)btnSavedLocation:(id)sender;
- (IBAction)btnNewLocation:(id)sender;
@property (nonatomic, strong) CLLocationManager* locationManager;
@end
