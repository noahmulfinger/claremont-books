//
//  CMBMainScreenViewController.h
//  ClaremontBooks
//
//  Created by Chris on 2/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMBProfileViewController.h"
#import "CMBBookListingsViewController.h"

@interface CMBMainScreenViewController : UIViewController

@property IBOutlet UISearchBar *bookSearchBar;

@property (strong) NSString *userName;
@property NSInteger userID;

@end
