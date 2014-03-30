//
//  CMBLoginScreenViewController.h
//  ClaremontBooks
//
//  Created by Chris on 3/10/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBLoginScreenViewController : UIViewController

@property (strong) IBOutlet UITextField *username;
@property (strong) IBOutlet UITextField *password;

@property (strong) IBOutlet UIButton *login;

@property (strong) NSString *response;

- (void) alertStatus:(NSString *)msg :(NSString *)title;

-(IBAction)loginClicked:(id)sender;

@end
