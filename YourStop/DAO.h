//
//  DAO.h
//  YourStop
//
//  Created by Chad Wiedemann on 11/18/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"

@interface DAO : NSObject

+ (DAO*)sharedInstanceOfDAO;
@property (nonatomic,strong) NSMutableArray <Destination*> *destinationsArray;


@end
