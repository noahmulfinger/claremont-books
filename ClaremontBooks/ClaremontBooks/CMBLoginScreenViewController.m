//
//  CMBLoginScreenViewController.m
//  ClaremontBooks
//
//  Created by Chris on 3/10/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBLoginScreenViewController.h"

@interface CMBLoginScreenViewController ()

@end

@implementation CMBLoginScreenViewController

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
    
<<<<<<< HEAD
    // Set the following for testing (so we don't need to continually type in the login, etc)
    //self.username.text = @"byan@hmc.edu";
    //self.password.text = @"claremont";
    
    
=======
>>>>>>> FETCH_HEAD
    
    self.title = @"Claremont Books";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Login prompt
- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

// Process the button click for login (data sent via HTTP POST
- (IBAction)loginClicked:(id)sender {
    @try {
        
        if([_username.text isEqualToString:@""] || [_password.text isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"uemail=%@&password=%@",_username.text,_password.text];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/loginjson.php"];
            
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
                
                NSDictionary* jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      
                                      options:kNilOptions
                                      error:&error];
                
                
                NSLog(@"%@",jsonData);
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                NSInteger userID = [(NSNumber *) [jsonData objectForKey:@"user_id"] integerValue];
                NSString *userName = [jsonData objectForKey:@"user_name"];

                
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    
                    // Read in username here (may need to be revised for future revisions)
                    self.userID = userID;
                    self.userName = userName;
                    
                    // Navigate to main
                    [self performSegueWithIdentifier: @"segueToMain" sender: self];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:error_msg :@"Login Failed!"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueToMain"]){
        UINavigationController *navController = (UINavigationController*)segue.destinationViewController;
        CMBMainScreenViewController *controller = (CMBMainScreenViewController*)[navController topViewController];
        NSLog(@"%ld", self.userID);
        controller.userID = self.userID;
        controller.userName = self.userName;
        NSLog(@"%ld", self.userID);
    }
}

@end
