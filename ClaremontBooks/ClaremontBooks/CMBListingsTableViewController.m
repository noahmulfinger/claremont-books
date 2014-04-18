//
//  CMBListingsTableViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBListingsTableViewController.h"

@interface CMBListingsTableViewController ()

@end

@implementation CMBListingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.title = @"Listings";
    
    
//    // For now we hard code JSON info. Eventually, we will read it from web (once formatted correctly)
//    NSString *jsonString = @"{\"listings\":[{\"id\":23,\"price\":30.0,\"condition\":\"Fair\",\"Seller\":\"Mable\",\"email\":\"mable@hmc.edu\"},{\"id\":24,\"price\":35.0,\"condition\":\"Good\",\"Seller\":\"Bessie\",\"email\":\"bessie@hmc.edu\"}]}";
//    //NSLog(@"%@", jsonString);
//    NSError *error =  nil;
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
//    NSInteger bookid = 1;
//    
//    
//    NSData* data = [NSData dataWithContentsOfURL:
//                    [NSURL URLWithString:
//                     [NSString stringWithFormat: @"http://www.claremontbooks.com/listings.php?target=%ld&show=json", (long)bookid]]];
//    
//    //parse out the json data
//    NSError* error;
//    NSDictionary* json = [NSJSONSerialization
//                          JSONObjectWithData:data //1
//                          
//                          options:kNilOptions
//                          error:&error];
//    
//    _listings = [json objectForKey:@"listings"]; //2
    
    
    
    
    
    @try {
        NSString *post;
        
        if ([self.searchType isEqual:@"bookid"]) {
            post = [[NSString alloc] initWithFormat:@"bookid=%ld&", (long) self.bookID];
        } else if ([self.searchType isEqual:@"userid"]){
            post = [[NSString alloc] initWithFormat:@"userid=%ld&", (long) self.userID];
        }
        
//        NSString *post =[[NSString alloc] initWithFormat:@"bookid=%ld&", (long) self.bookID];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/listingsMobile.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        
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
            
            _listings = [jsonData objectForKey:@"listings"];
            
            
            NSLog(@"%@",jsonData);
//                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
//                NSLog(@"%d",success);
            
            
//                if(success == 1)
//                {
//                    NSLog(@"Upload SUCCESS");
//                    //[self alertStatus:@"Uploaded Successfully." :@"Upload Success!"];
//                    
//                    
//                    // Navigate
//                    [self.navigationController popViewControllerAnimated:YES];
//                    
//                } else {
//                    
//                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
//                    NSLog(@"Error: %@", error_msg);
////                    [self alertStatus:error_msg :@"Book Listing Failed to Upload!"];
//                }
            
            
            
        } else {
            if (error) NSLog(@"Error: %@", error);
//                [self alertStatus:@"Connection Failed" :@"Upload Failed!"];
        }
    }
    
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
//        [self alertStatus:@"Upload Failed." :@"Upload Failed!"];
    }
    
    //_listings = [json objectForKey:@"listings"];
    
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)deleteListing:(id)sender {
    @try {
        
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
                    self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _listings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListingCell";
    CMBListingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *listing = [_listings objectAtIndex:indexPath.row];
    
    NSNumber* price = [listing objectForKey:@"price"];
    NSString* condition = [listing objectForKey:@"condition"];
    NSString* seller = [listing objectForKey:@"sellername"];
    NSString* email = [listing objectForKey:@"email"];
    
    
    
    cell.price.text = [NSString stringWithFormat:@"$%@", price];
    cell.condition.text = condition;
    [cell.seller setTitle:seller forState:UIControlStateNormal];
    [cell.seller setTitle:seller forState:UIControlStateSelected];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //set the position of the button
    button.frame = CGRectMake(cell.frame.origin.x + 100, cell.frame.origin.y + 20, 100, 30);
    [button setTitle:@"World" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleteListing:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor= [UIColor clearColor];
    [cell.contentView addSubview:button];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMBListingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.bookTitleToSend = cell.title.text;
    self.bookIDToSend = cell.bookID;
    
    [self performSegueWithIdentifier:@"listingsToListing" sender:indexPath];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"listingsToListing"]){
        CMBListingViewController *controller = (CMBListingViewController *)segue.destinationViewController;
        controller.bookTitle.text = self.bookTitleToSend;
        controller.author.text = self.authorToSend;
        controller.edition.text = self.editionToSend;
        controller.ISBN.text = self.ISBNToSend;
        controller.binding.text = self.bindingToSend;
        controller.condition.text = self.conditionToSend;
        controller.price.text = self.priceToSend;
        controller.status.text = self.statusToSend;
        controller.seller.titleLabel.text = self.sellerToSend;
        
        controller.bookID = self.bookIDToSend;
    }
}

@end
