//
//  CMBBookCell.m
//  ClaremontBooks
//
//  Created by Chris on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBBookCell.h"

@implementation CMBBookCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
