//
//  DAO.m
//  YourStop
//
//  Created by chutima mungmee on 11/16/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "DAO.h"

@implementation DAO

+(DAO *)sharedInstance
{
    static DAO *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DAO alloc]init];
    });
    
    return sharedInstance;
    
}


@end
