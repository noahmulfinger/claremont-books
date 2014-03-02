//
//  CMBNewListingViewController.h
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBNewListingViewController : UIViewController

@property (strong) IBOutlet UITextField *price;
@property (strong) IBOutlet UITextField *condition;
@property (strong) IBOutlet UITextField *email;
@property (strong) IBOutlet UITextView *comments;

@property (strong) IBOutlet UILabel *humanReadble;

@end
