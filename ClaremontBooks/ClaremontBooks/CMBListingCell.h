//
//  CMBListingCell.h
//  ClaremontBooks
//
//  Created by Chris on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBListingCell : UITableViewCell

@property (strong) IBOutlet UILabel *title;
@property (strong) IBOutlet UILabel *author;
@property (strong) IBOutlet UILabel *edition;
@property (strong) IBOutlet UILabel *ISBN;
@property (strong) IBOutlet UILabel *binding;

@property (strong) IBOutlet UILabel *price;
@property (strong) IBOutlet UILabel *condition;
@property (strong) IBOutlet UIButton *seller;
@property (strong) IBOutlet UIButton *email;

@property NSInteger bookID;
@property NSInteger listID;

@end
