//
//  CMBListingPreviewViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBListingPreviewViewController.h"

@interface CMBListingPreviewViewController ()

@end

@implementation CMBListingPreviewViewController

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

- (IBAction) popToRootViewController:(id)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
