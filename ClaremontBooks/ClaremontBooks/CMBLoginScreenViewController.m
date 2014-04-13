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

//@synthesize response;

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

//-(IBAction)ButtonClicked:(id)sender
//{
////    NSString *content = @"username=blabla&password=123456";
////    NSData *data=[content dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
////    NSString *postlenght=[NSString stringWithFormat:@"%d",[data length]];
////    
////    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://roadster.co.il/forums/ucp.php?mode=login"]];
////    [request setHTTPMethod:@"POST"];
////    [request setValue:postlenght forHTTPHeaderField:@"Content-Length"];
////    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Length"];
////    [request setHTTPBody:data];
////    NSError *error=nil;
////    NSURLResponse *response=nil;
////    NSData *result=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
////    
////    [webview loadRequest:request];
//    
//    NSURL *url = [NSURL URLWithString: @"http://www.claremontbooks.com/connection.php"];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
//    if (connection) {
//        // Connect
//    } else {
//        // Error
//    }
//}






- (IBAction)loginClicked:(id)sender {
    @try {
        
        if([_username.text isEqualToString:@""] || [_password.text isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"uemail=%@&password=%@",_username.text,_password.text];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/loginjson.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
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
            
            NSLog(@"Response code: %d", [response statusCode]);
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
                NSInteger userID = [(NSNumber *) [jsonData objectForKey:@"user_id"] integerValue];
                
                //NSLog(@"%ld",(long)success);
               // NSLog(@"%@",@"Hello");
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    
                    // It might be a good idea to change how you read in username
        
                    self.userID = userID;
                    
                    // Navigate
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
        NSLog(@"%ld", self.userID);
        
        
        
        
    }
}

    
    
    
    
    
    
    
    
    

//- (void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
//    response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//}

//- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
//    
//    // Will replace with desired behavior
//    if ([response isEqualToString:@"1"]) {
//        NSLog(@"Success");
//    } else {
//        NSLog(@"Failue");
//    }
//    
//    connection = nil;
//}

@end
