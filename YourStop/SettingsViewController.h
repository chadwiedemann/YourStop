//
//  SettingsViewController.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetDestinationViewController.h"
#import "Destination.h"
#import "DAO.h"
#import "DestinationTableViewController.h"

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) Destination *editingDestination;
- (IBAction)changeSlider:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txfLocationName;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewDistance;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewRingTone;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;

@property (weak, nonatomic) IBOutlet UILabel *lblDistanceDisplay;
@property (weak, nonatomic) IBOutlet UILabel *lblRingToneDisplay;

@property (weak, nonatomic) IBOutlet UIView *middleViewLayer;
@property (weak, nonatomic) IBOutlet UIView *bottomViewLayer;



- (IBAction)btnNameDone:(id)sender;

- (IBAction)btnSavePressed:(id)sender;


@end
