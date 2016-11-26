//
//  DestinationMO+CoreDataProperties.m
//  YourStop
//
//  Created by Chad Wiedemann on 11/25/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "DestinationMO+CoreDataProperties.h"

@implementation DestinationMO (CoreDataProperties)

+ (NSFetchRequest<DestinationMO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DestinationMO"];
}

@dynamic destinationName;
@dynamic miles;
@dynamic ringTone;
@dynamic destinationID;
@dynamic latitude;
@dynamic longitude;

@end
