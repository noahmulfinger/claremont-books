//
//  CMBBookViewController.m
//  ClaremontBooks
//
//  Created by Chris on 4/7/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBBookViewController.h"

@interface CMBBookViewController ()

@end

@implementation CMBBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"Does it init with nib? Nope.");
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (Ed. %@)", self.bookName, self.bookEdition];
    self.authorLabel.text = [NSString stringWithFormat:@"by %@",self.bookAuthor];
    self.ISBNLabel.text = [NSString stringWithFormat:@"ISBN: %@", self.bookISBN];
    self.bindingLabel.text = [NSString stringWithFormat:@"Binding: %@", self.bookBinding];
    //NSLog(@"%d", *self.bookID);
    NSLog(@"bookid = %li", self.bookID);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"bookViewToListings"]){
        CMBListingsTableViewController *controller = (CMBListingsTableViewController *)segue.destinationViewController;
        controller.bookName = self.bookName;
        controller.bookID = self.bookID;
        controller.searchType = @"bookid";

    } else if ([segue.identifier isEqualToString:@"bookViewToNewListing"]){
        CMBNewListingViewController *controller = (CMBNewListingViewController *)segue.destinationViewController;
        controller.bookName = self.bookName;
        controller.bookID = self.bookID;
        controller.bookAuthor = self.bookAuthor;
        controller.bookISBN = self.bookISBN;
        controller.bookBinding = self.bookBinding;
        controller.bookEdition = self.bookEdition;
        controller.userID = self.userID;
        NSLog(@"%s", "Gets past prepare for segue");
    }

}

@end
