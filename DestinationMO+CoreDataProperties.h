//
//  DestinationMO+CoreDataProperties.h
//  YourStop
//
//  Created by Chad Wiedemann on 11/25/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "DestinationMO+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DestinationMO (CoreDataProperties)

+ (NSFetchRequest<DestinationMO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *destinationName;
@property (nonatomic) double miles;
@property (nullable, nonatomic, copy) NSString *ringTone;
@property (nonatomic) int64_t destinationID;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end

NS_ASSUME_NONNULL_END
