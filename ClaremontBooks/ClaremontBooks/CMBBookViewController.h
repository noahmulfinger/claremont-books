//
//  CMBBookViewController.h
//  ClaremontBooks
//
//  Created by Chris on 4/7/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMBListingsTableViewController.h"
#import "CMBNewListingViewController.h"

@interface CMBBookViewController : UIViewController

@property (strong) NSString *bookName;
@property (strong) NSString *bookAuthor;
@property (strong) NSString *bookEdition;
@property (strong) NSString *bookISBN;
@property (strong) NSString *bookBinding;
@property NSInteger bookID;

@property (strong) IBOutlet UILabel *titleLabel;
@property (strong) IBOutlet UILabel *authorLabel;
@property (strong) IBOutlet UILabel *ISBNLabel;
@property (strong) IBOutlet UILabel *bindingLabel;

@end
