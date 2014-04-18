//
//  CMBListingsTableViewController.h
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMBListingCell.h"
#import "CMBListingViewController.h"

@interface CMBListingsTableViewController : UITableViewController

@property (strong) NSMutableArray *listings;

@property (strong) NSString *searchType;
@property (strong) NSString *userName;
@property NSInteger userID;
@property (strong) NSString *bookName;
@property NSInteger bookID;

@property (strong) NSString *bookTitleToSend;
@property (strong) NSString *authorToSend;
@property (strong) NSString *editionToSend;
@property (strong) NSString *ISBNToSend;
@property (strong) NSString *bindingToSend;
@property (strong) NSString *conditionToSend;
@property (strong) NSString *priceToSend;
@property (strong) NSString *statusToSend;
@property (strong) NSString *sellerToSend;


@property NSInteger bookIDToSend;


@end
