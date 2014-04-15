//
//  CMBListingViewController.h
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBListingViewController : UIViewController

@property (strong) IBOutlet UILabel *bookTitle;
@property (strong) IBOutlet UILabel *author;
@property (strong) IBOutlet UILabel *edition;
@property (strong) IBOutlet UILabel *ISBN;
@property (strong) IBOutlet UILabel *binding;
@property (strong) IBOutlet UILabel *condition;
@property (strong) IBOutlet UILabel *price;
@property (strong) IBOutlet UILabel *status;

@property NSInteger bookID;

@property (strong) IBOutlet UIButton *seller;
@property (strong) IBOutlet UIButton *email;

- (IBAction)deleteListing:(id)sender;

@end
