//
//  DestinationTableViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "DestinationTableViewController.h"
#import "DestinationTableViewCell.h"
#import "Destination.h"
#import "SetDestinationViewController.h"
#import "ConfirmDestinationViewController.h"

@interface DestinationTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DestinationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.destinationTableView.delegate = self;
    
    // Test, fake destination object for testing the table view
    Destination *home = [[Destination alloc]initWithLocation:CLLocationCoordinate2DMake(40.707547, -74.011899)];
    home.destinationName = @"Home";
    home.miles = .1;
    
    Destination *work = [[Destination alloc]init];
    work.destinationName = @"Work";
    work.miles = 1;
    
    self.destinationsArray = [[NSMutableArray alloc]init];
    
    [self.destinationsArray addObject:home];
    [self.destinationsArray addObject:work];
    
    // Set up the navigation bar
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewLocation)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    

    
    // Allow the select the cell during the editing mode
    self.destinationTableView.allowsSelectionDuringEditing = YES;
    
    // Check that there are any destination in array yet
    // if there are no destination, show the empty view instead of table view
    if (self.destinationsArray.count == 0) {
        self.emptyView.hidden = NO;
    } else {
        
        self.emptyView.hidden = YES;
    }
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

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.destinationsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create custom table view cell here
    static NSString *cellIdentifier = @"DestinationTableViewCell";
    
    DestinationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DestinationTableViewCell" owner:self options:nil];
        
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    // Configure the cell
    
    Destination *eachDestination = [self.destinationsArray objectAtIndex:indexPath.row];
    cell.lblDestinationName.text = eachDestination.destinationName;
    cell.lblDistance.text = [NSString stringWithFormat:@"Will awake you %.1f mile before your destination", eachDestination.miles];
    cell.imageView.image = [UIImage imageNamed:@"google_place_1"];
    
    // ADD accessory type to be able to edit the cell
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Destination *destination = self.destinationsArray[indexPath.row];
    
    
    // Create the new view controller
    // Set it to the confirm destination view controller
    // Pass the destination object to the next view controller
    ConfirmDestinationViewController *confirmDestinatinVC = [[ConfirmDestinationViewController alloc]initWithNibName:@"ConfirmDestinationViewController" bundle:nil];
    
    confirmDestinatinVC.selectedLocation = destination;
    
    [self.navigationController pushViewController:confirmDestinatinVC animated:YES];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the location on the row
        [self.destinationsArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [tableView reloadData];
    
    if (self.destinationsArray.count == 0) {
        self.emptyView.hidden = NO;
    }
}

#pragma mark - Convenient Functions

-(void)addNewLocation
{
    // Create the next view controller
    SetDestinationViewController *setDestinationVC = [[SetDestinationViewController alloc]initWithNibName:@"SetDestinationViewController" bundle:nil];
    
    [self.navigationController pushViewController:setDestinationVC animated:YES];
    
}



@end
