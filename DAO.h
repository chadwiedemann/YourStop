//
//  DAO.h
//  YourStop
//
//  Created by chutima mungmee on 11/16/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"

@interface DAO : NSObject

@property (nonatomic, strong) NSMutableArray *destinationsArray;

+(DAO *)sharedInstance;

@end
