//
//  IgnoreView.m
//  YourStop
//
//  Created by Chad Wiedemann on 2/20/17.
//  Copyright © 2017 Chad Wiedemann LLC. All rights reserved.
//

#import "IgnoreView.h"

@implementation IgnoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // UIView will be "transparent" for touch events if we return NO
    return NO;
}

@end
