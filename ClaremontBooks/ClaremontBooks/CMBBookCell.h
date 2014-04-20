//
//  CMBBookCell.h
//  ClaremontBooks
//
//  Created by Chris on 3/3/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBBookCell : UITableViewCell

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

//@property (strong, nonatomic) NSString *authorS;
@property NSInteger bookID;


@end
