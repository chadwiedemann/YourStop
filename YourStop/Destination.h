//
//  Destination.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Destination : NSObject

@property (nonatomic, strong) NSString *destinationName;
@property CLLocationCoordinate2D destinationCoordinate;
@property double miles;
@property (nonatomic, strong) NSString *ringTone;
@property BOOL vibration;



@end
