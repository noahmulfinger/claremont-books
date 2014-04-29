//
//  CMBNewBookEntryViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBNewBookEntryViewController.h"
#import "CMBNewBookEntryView.h"
#import "CMBBookListingsViewController.h"

@interface CMBNewBookEntryViewController ()

@end


@implementation CMBNewBookEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.bookTitle.delegate = self;
    self.author.delegate = self;
    self.edition.delegate = self;
    self.ISBN.delegate = self;
    self.binding.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (IBAction) insert:(id)sender
{
    
    @try {
        
        if([_bookTitle.text isEqualToString:@""] || [_author.text isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Title and Author" :@"Upload Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"bookTitle=%@&bookAuthor=%@&bookEdition=%@&bookISBN=%@&bookBinding=%@&",_bookTitle.text, _author.text, _edition.text, _ISBN.text, _binding.text];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/insertBookMobile.php"];
            
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
                NSLog(@"%ld",(long) success);
                if(success == 1)
                {
                    NSLog(@"Upload SUCCESS");
                    //[self alertStatus:@"Uploaded Successfully." :@"Upload Success!"];
                    
                    // Navigate
                    [self.navigationController popViewControllerAnimated:YES];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:error_msg :@"Book Listing Failed to Upload!"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Upload Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Upload Failed." :@"Upload Failed!"];
    }
    
}

@end
