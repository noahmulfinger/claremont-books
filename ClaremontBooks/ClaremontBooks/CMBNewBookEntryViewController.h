//
//  CMBNewBookEntryViewController.h
//  ClaremontBooks
//
//  Created by Chris on 2/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBNewBookEntryViewController : UIViewController <UITextFieldDelegate>

@property (strong) IBOutlet UITextField *bookTitle;
@property (strong) IBOutlet UITextField *author;
@property (strong) IBOutlet UITextField *ISBN;
@property (strong) IBOutlet UITextField *edition;
@property (strong) IBOutlet UITextField *binding;

@property (strong) IBOutlet UIButton *post;

- (IBAction) insert:(id)sender;

@end
