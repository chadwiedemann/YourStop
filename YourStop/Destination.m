//
//  Destination.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "Destination.h"

@implementation Destination

@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if(![defaults integerForKey:@"destinationID"]){
            [defaults setInteger:1 forKey:@"destinationID"];
            self.destinationID = 1;
        }else{
            self.destinationID = [defaults integerForKey:@"destinationID"]+1;
            [defaults setInteger:self.destinationID forKey:@"destinationID"];
        }
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    NSLog(@"got called");
    coordinate = newCoordinate;
}

@end
