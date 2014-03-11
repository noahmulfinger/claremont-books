//
//  CMBBookListingsViewController.h
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBBookListingsViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong) NSMutableArray *books;

@property (strong) NSMutableArray *filteredBookArray;
@property IBOutlet UISearchBar *bookSearchBar;

@end
