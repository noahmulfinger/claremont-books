//
//  CMBNewListingViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBNewListingViewController.h"

@interface CMBNewListingViewController () {
    IBOutlet UIButton *sellerNameButton;
    IBOutlet UIButton *selllerEmailButton;
}

@end



@implementation CMBNewListingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%@", @"goes to init in listing view controller");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", self.bookName);

    
	// Do any additional setup after loading the view.
    self.titleLabel.text = [NSString stringWithFormat:@"%@", self.bookName];
    self.editionLabel.text = [NSString stringWithFormat:@"%@", self.bookEdition];
    self.ISBNLabel.text = [NSString stringWithFormat:@"%@",self.bookISBN];
    self.authorLabel.text = [NSString stringWithFormat:@"%@",self.bookAuthor];
    self.bindingLabel.text = [NSString stringWithFormat:@"%@",self.bookBinding];
    
    // change the seller name and email button text below (doesn't work)
    //self.sellerNameLabel.text = [NSString stringWithFormat:@"%@", self.sellerName];
    //self.selllerEmailLabel.text = [NSString stringWithFormat:@"%@", self.sellerEmail];
    
}

- (IBAction)addListing:(id)sender {
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@"bookid=%ld&price=%@&userid=%ld", self.bookID, _price.text, self.userID];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/addListingMobile.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            
            //                NSData* data = [NSData dataWithContentsOfURL:
            //                                [NSURL URLWithString:
            //                                 @"http://www.claremontbooks.com/books.php?show=json"]];
            //
            
            NSLog(@"Response ==> %@", responseData);
            
            //                SBJsonParser *jsonParser = [SBJsonParser new];
            //                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
            //                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
            
            NSDictionary* jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      
                                      options:kNilOptions
                                      error:&error];
            
            
            NSLog(@"%@",jsonData);
            NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
            
            if (success == 1) {
                 //Return to home screen 
                 [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
            
        } else {
            if (error) NSLog(@"Error: %@", error);
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
