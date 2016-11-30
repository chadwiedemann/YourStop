//
//  DestinationTableViewController.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationTableViewController : UIViewController 

@property (nonatomic, strong) NSMutableArray *destinationsArray;

@property (weak, nonatomic) IBOutlet UITableView *destinationTableView;
@property (weak, nonatomic) IBOutlet UIView *emptyView;

- (IBAction)btnAddNewLocation:(id)sender;

@end
