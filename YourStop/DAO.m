//
//  DAO.m
//  YourStop
//
//  Created by Chad Wiedemann on 11/18/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "DAO.h"

@implementation DAO

-(id)init
{
    self = [super init];
    if(self)
    {
        self.destinationsArray = [[NSMutableArray alloc]init];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSSortDescriptor *sortByCreationDate = [[NSSortDescriptor alloc]
                                                initWithKey:@"destinationID" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortByCreationDate]];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DestinationMO" inManagedObjectContext:[self managedObjectContext]];
        [fetchRequest setEntity:entity];
        NSError *error = nil;
        NSArray *fetchedCompanies = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        if (fetchedCompanies == nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        self.destinationsArrayMO = [fetchedCompanies mutableCopy];
        
        for (DestinationMO *des in self.destinationsArrayMO)
        {
            [self.destinationsArray addObject:[self createDestinationFromMO:des]];
        }
    }
    return self;
}



+ (DAO*)sharedInstanceOfDAO
{
    // 1
    static DAO *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DAO alloc] init];
    });
    return _sharedInstance;
}

-(void)addDestination:(Destination *)destination
{
    if(self.destinationsArray == nil){
        self.destinationsArray = [[NSMutableArray alloc]init];
    }
    [self.destinationsArray addObject:destination];
    
    DestinationMO *newDestination = [NSEntityDescription insertNewObjectForEntityForName:@"DestinationMO" inManagedObjectContext:[self managedObjectContext]];
    
    newDestination.destinationName = destination.destinationName;
    newDestination.miles = destination.miles;
    newDestination.destinationID = destination.destinationID;
    newDestination.ringTone = destination.ringTone;
    newDestination.latitude = destination.coordinate.latitude;
    newDestination.longitude = destination.coordinate.longitude;
    
    [self.destinationsArrayMO addObject:newDestination];
    [self saveContext];
    
    
}

-(void)deleteDestination: (Destination*) destination
{
    for (Destination *des in self.destinationsArray) {
        if(destination.destinationID == des.destinationID)
        {
            [self.destinationsArray removeObject:des];
        }
    }
    
    for (DestinationMO *des in self.destinationsArrayMO) {
        if(destination.destinationID == des.destinationID)
        {
            [self.destinationsArrayMO removeObject:des];
        }
    }
    [self saveContext];
}


-(Destination*)createDestinationFromMO: (DestinationMO*) destinationMO
{
//    double lat = destinationMO.latitude;
//    double longit = destinationMO.longitude;
    CLLocationDegrees lat = destinationMO.latitude;
    CLLocationDegrees longit = destinationMO.longitude;
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lat, longit);
    
    Destination *tempDestination = [[Destination alloc]initWithLocation:location];
    tempDestination.ringTone = destinationMO.ringTone;
    tempDestination.destinationID = destinationMO.destinationID;
    tempDestination.destinationName = destinationMO.destinationName;
    tempDestination.miles = destinationMO.miles;
    
    return tempDestination;
    
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "turntotech.io.core_data_example" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"YourStop" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"YourStop.sqlite"];
    NSLog(@"%@",storeURL);
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
