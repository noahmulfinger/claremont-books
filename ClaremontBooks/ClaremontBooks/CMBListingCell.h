//
//  CMBListingCell.h
//  ClaremontBooks
//
//  Created by Chris on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBListingCell : UITableViewCell

//@property (strong) IBOutlet UILabel *title;
//@property (strong) IBOutlet UILabel *author;
//@property (strong) IBOutlet UILabel *edition;
//@property (strong) IBOutlet UILabel *ISBN;
//@property (strong) IBOutlet UILabel *binding;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *edition;
@property (strong, nonatomic) NSString *ISBN;
@property (strong, nonatomic) NSString *binding;
@property (strong, nonatomic) NSString *sname;
@property (strong, nonatomic) NSString *semail;

@property (strong) IBOutlet UILabel *price;
@property (strong) IBOutlet UILabel *condition;
@property (strong) IBOutlet UIButton *seller;
@property (strong) IBOutlet UIButton *email;

@property NSInteger bookID;

@end
