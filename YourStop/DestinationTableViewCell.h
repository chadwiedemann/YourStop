//
//  DestinationTableViewCell.h
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *destinationImage;
@property (weak, nonatomic) IBOutlet UILabel *lblDestinationName;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;


@end
