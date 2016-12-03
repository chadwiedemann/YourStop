//
//  DAO.h
//  YourStop
//
//  Created by Chad Wiedemann on 11/18/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"
#import <CoreData/CoreData.h>
#import "DestinationMO+CoreDataClass.h"

@interface DAO : NSObject

+ (DAO*)sharedInstanceOfDAO;
@property (nonatomic,strong) NSMutableArray <Destination*> *destinationsArray;
@property (nonatomic, strong) NSMutableArray <DestinationMO*> *destinationsArrayMO;
@property BOOL isSleeping;
@property BOOL commuteTooLong;

-(void)addDestination: (Destination*) destination;
-(void)deleteDestination: (Destination*) destination;
-(Destination*)createDestinationFromMO: (DestinationMO*) destinationMO;


//core data setup
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
