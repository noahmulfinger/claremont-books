//
//  CMBProfileViewController.m
//  ClaremontBooks
//
//  Created by Chris on 4/8/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBProfileViewController.h"

@interface CMBProfileViewController ()

@end

@implementation CMBProfileViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"profileToListings"]){
        
        CMBListingsTableViewController *controller = (CMBListingsTableViewController *)segue.destinationViewController;
        controller.userName = self.userName;
        controller.userID = self.userID;
        controller.searchType = @"userid";
    }
}

@end
