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
#import "DAO.h"

@interface DestinationTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DestinationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.destinationTableView.delegate = self;
    self.destinationsArray = [[NSMutableArray alloc]init];
    DAO *dataAccess = [DAO sharedInstanceOfDAO];
    [self.destinationsArray addObjectsFromArray:dataAccess.destinationsArray];
    
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
}

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
    cell.lblDistance.text = [NSString stringWithFormat:@"YourStop will wake you %.1f miles before your destination", eachDestination.miles];
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
        DAO *access = [DAO sharedInstanceOfDAO];
        [self.destinationsArray removeObjectAtIndex:indexPath.row];
        [access.destinationsArray removeObjectAtIndex:indexPath.row];
        [access.managedObjectContext deleteObject:[access.destinationsArrayMO objectAtIndex:indexPath.row]];
        [access.destinationsArrayMO removeObjectAtIndex:indexPath.row];
        [access saveContext];
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

- (IBAction)btnAddNewLocation:(id)sender {
    // Create the next view controller
    SetDestinationViewController *setDestinationVC = [[SetDestinationViewController alloc]initWithNibName:@"SetDestinationViewController" bundle:nil];
    [self.navigationController pushViewController:setDestinationVC animated:YES];
}

@end
