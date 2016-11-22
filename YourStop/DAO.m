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



@end
