//
//  LocationManager.h
//  YourStop
//
//  Created by chutima mungmee on 11/28/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol LocationManagerDelegate <NSObject>

-(void) didUpdateLocation:(CLLocation *)location;

@end

@interface LocationManager : NSObject

@property (nonatomic, weak) id<LocationManagerDelegate> delegate;

+ (instancetype)sharedInstance;
- (void)startUpdatingLocation;
-(void) stopUpdatingLocation;

@end
