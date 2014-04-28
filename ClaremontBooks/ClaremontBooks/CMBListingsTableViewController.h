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

@property (strong) NSMutableArray *filteredListingArray;

@property (strong) NSString *searchType;
@property (strong) NSString *userName;
@property NSInteger userID;
@property (strong) NSString *bookName;
@property NSInteger bookID;

@property (strong) NSString *bookTitleToSend;
@property (strong) NSString *bookAuthorToSend;
@property (strong) NSString *bookEditionToSend;
@property (strong) NSString *bookISBNToSend;
@property (strong) NSString *bookBindingToSend;
@property (strong) NSString *bookConditionToSend;
@property (strong) NSString *bookPriceToSend;
@property (strong) NSString *bookStatusToSend;
@property (strong) NSString *sellerNameToSend;
@property (strong) NSString *sellerEmailToSend;

@property NSInteger bookIDToSend;

@property BOOL displayingUserListings;

-(void)updateListings;
-(void)deleteListing:(id)sender;

@end
