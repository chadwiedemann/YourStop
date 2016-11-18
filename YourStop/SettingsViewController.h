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

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) Destination *editingDestination;

@end
