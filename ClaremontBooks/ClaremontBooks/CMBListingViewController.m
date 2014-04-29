//
//  CMBListingViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBListingViewController.h"

@interface CMBListingViewController () {
    IBOutlet UIButton *sellerNameButton;
    IBOutlet UIButton *selllerEmailButton;
}

@end

@implementation CMBListingViewController

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
    
	// Do any additional setup after loading the view.
    self.titleLabel.text = [NSString stringWithFormat:@"%@", self.bookName];
    self.editionLabel.text = [NSString stringWithFormat:@"%@", self.bookEdition];
    self.ISBNLabel.text = [NSString stringWithFormat:@"%@",self.bookISBN];
    self.authorLabel.text = [NSString stringWithFormat:@"%@",self.bookAuthor];
    self.bindingLabel.text = [NSString stringWithFormat:@"%@",self.bookBinding];
    self.conditionLabel.text = [NSString stringWithFormat:@"%@",@"Normal wear and tear."];
    self.priceLabel.text = [NSString stringWithFormat:@"%@", self.bookPrice];
    //self.statusLabel.text = [NSString stringWithFormat:@"%@", self.bookStatus];
    self.statusLabel.text = [NSString stringWithFormat:@"%@",@"Available."];
    
    // change the seller name and email button text below (doesn't work)
    //self.sellerNameLabel.text = [NSString stringWithFormat:@"%@", self.sellerName];
    //self.selllerEmailLabel.text = [NSString stringWithFormat:@"%@", self.sellerEmail];
    
    // change the seller name and email button text below (does work)
    [self.sellerNameButton setTitle:self.sellerName forState:UIControlStateNormal];
//    [self.sellerNameButton setTitle:@"PRINT NAME" forState:UIControlStateNormal];
    [self.selllerEmailButton setTitle:self.sellerEmail forState:UIControlStateNormal];
    //    [self.selllerEmailButton setTitle:@"PRINT EMAIL" forState:UIControlStateNormal];
    
}

// Deleting listings will be implemented in a later version
//- (IBAction)deleteListing:(id)sender {
//    @try{
//        NSString *post =[[NSString alloc] initWithFormat:@"listid=%ld",_];
//        NSLog(@"PostData: %@",post);
//        
//        NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/loginjson.php"];
//        
//        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        
//        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:url];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//        [request setHTTPBody:postData];
//        
//        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
//        
//        NSError *error = [[NSError alloc] init];
//        NSHTTPURLResponse *response = nil;
//        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        
//        NSLog(@"Response code: %d", [response statusCode]);
//        if ([response statusCode] >=200 && [response statusCode] <300)
//        {
//            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//            
//            //                NSData* data = [NSData dataWithContentsOfURL:
//            //                                [NSURL URLWithString:
//            //                                 @"http://www.claremontbooks.com/books.php?show=json"]];
//            //
//            
//            NSLog(@"Response ==> %@", responseData);
//            
//            //                SBJsonParser *jsonParser = [SBJsonParser new];
//            //                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
//            //                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
//            
//            NSDictionary* jsonData = [NSJSONSerialization
//                                      JSONObjectWithData:urlData
//                                      
//                                      options:kNilOptions
//                                      error:&error];
//            
//            
//            NSLog(@"%@",jsonData);
//            NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
//            
//            //NSLog(@"%ld",(long)success);
//            // NSLog(@"%@",@"Hello");
//            if(success == 1)
//            {
//                NSLog(@"Login SUCCESS");
//      //          [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
//                
//                // It might be a good idea to change how you read in username
//            
//                
//                // Navigate
//                [self performSegueWithIdentifier: @"segueToMain" sender: self];
//                
//            } else {
//                
//                NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
//       //         [self alertStatus:error_msg :@"Login Failed!"];
//            }
//            
//        } else {
//            if (error) NSLog(@"Error: %@", error);
//      //      [self alertStatus:@"Connection Failed" :@"Login Failed!"];
//        }
//
//    }
//    @catch (NSException * e) {
//        NSLog(@"Exception: %@", e);
//    }

//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
