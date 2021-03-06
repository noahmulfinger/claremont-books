//
//  CMBMainScreenViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBMainScreenViewController.h"

@interface CMBMainScreenViewController ()

@end

@implementation CMBMainScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Claremont Books";
    self.welcomeLabel.text = [NSString stringWithFormat:@"%@%@", @"Welcome, ", self.userName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"mainToProfile"]){
        CMBProfileViewController *controller = (CMBProfileViewController *)segue.destinationViewController;
        controller.userID = self.userID;
        
    } else if ([segue.identifier isEqualToString:@"AddListingToBookList"] || [segue.identifier isEqualToString:@"ListBooksToBookList"]) {
        CMBBookListingsViewController *controller = (CMBBookListingsViewController *)segue.destinationViewController;
        controller.userID = self.userID;

    }
}

@end
