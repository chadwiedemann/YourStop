//
//  Destination.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Destination : NSObject <MKAnnotation>

{
    CLLocationCoordinate2D coordinate;
}
- (id)initWithLocation:(CLLocationCoordinate2D)coord;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@property (nonatomic, strong) NSString *destinationName;
@property double miles;
@property (nonatomic, strong) NSString *ringTone;
@property NSInteger destinationID;
@property double latitude;
@property double longitude;



@end
