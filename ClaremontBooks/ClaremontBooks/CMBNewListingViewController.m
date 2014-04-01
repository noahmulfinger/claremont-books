//
//  CMBNewListingViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//


#import "CMBNewListingViewController.h"

@interface CMBNewListingViewController ()

@end

@implementation CMBNewListingViewController

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
    
    // Get info from www.claremontbooks.com
//    dispatch_async(dispatch_get_global_queue(
//                                             DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        [NSURL URLWithString:
//                         @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]];
//        [self performSelectorOnMainThread:@selector(fetchedData:)
//                               withObject:data waitUntilDone:YES];
//    });
    
}



- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    NSLog(@"loans: %@", latestLoans); //3
    
    
    
    
    
    // 1) Get the latest loan
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    
    // 2) Get the funded amount and loan amount
    NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
    NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
    float outstandingAmount = [loanAmount floatValue] -
    [fundedAmount floatValue];
    
    // 3) Set the label appropriately
//    _humanReadble.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
//                         [loan objectForKey:@"name"],
//                         [(NSDictionary*)[loan objectForKey:@"location"]
//                          objectForKey:@"country"],
//                         outstandingAmount];
    
    
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
