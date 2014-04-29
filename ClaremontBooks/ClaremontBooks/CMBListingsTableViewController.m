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
    [self updateListings];
    
}


-(void)updateListings {
    
    
    self.title = @"Listings";
    
    self.displayingUserListings = false;
    
    @try {
        NSString *post;
        
        if ([self.searchType isEqual:@"bookid"]) {
            post = [[NSString alloc] initWithFormat:@"bookid=%ld&", (long) self.bookID];
        } else if ([self.searchType isEqual:@"userid"]){
            post = [[NSString alloc] initWithFormat:@"userid=%ld&", (long) self.userID];
            self.displayingUserListings = true;
        }
        
        //        NSString *post =[[NSString alloc] initWithFormat:@"bookid=%ld&", (long) self.bookID];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/listingsMobile.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
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
            
            _listings = [jsonData objectForKey:@"listings"];
            
            self.filteredListingArray = [NSMutableArray arrayWithCapacity:[_listings count]];
            
            
            NSLog(@"%@",jsonData);           
            
            
        } else {
            if (error) NSLog(@"Error: %@", error);
            //                [self alertStatus:@"Connection Failed" :@"Upload Failed!"];
        }
    }
    
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //        [self alertStatus:@"Upload Failed." :@"Upload Failed!"];
    }
    
    [super viewDidLoad];
}




- (IBAction)delete:(id)sender {

}

- (void)deleteListing:(id)sender {
    @try {
            UIButton *button = (UIButton *) sender;
            NSString *post =[[NSString alloc] initWithFormat:@"listid=%ld",(long)button.tag];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.claremontbooks.com/deleteListingMobile.php"];
        
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
                    [self updateListings];
                    [self.tableView reloadData];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    return _listings.count;
    return (tableView==self.tableView)?self.listings.count:self.filteredListingArray.count;
}

- (CMBListingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListingCell";
    CMBListingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[CMBListingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
                            
//    NSDictionary *listing = [_listings objectAtIndex:indexPath.row];
    
    NSDictionary *dToAccess = (self.tableView==tableView)?[self.listings objectAtIndex:indexPath.row] : [self.filteredListingArray objectAtIndex:indexPath.row];
    
    NSString* title = [dToAccess objectForKey:@"title"];//
    NSString* author = [dToAccess objectForKey:@"author"];//
    NSNumber* edition = [dToAccess objectForKey:@"edition"];//
    NSNumber* ISBN = [dToAccess objectForKey:@"isbn"];
    NSString* binding = [dToAccess objectForKey:@"binding"];
    //NSNumber* bookID = [dToAccess objectForKey:@"bookid"];
    NSNumber* price = [dToAccess objectForKey:@"price"];//
    NSString* condition = [dToAccess objectForKey:@"condition"];
    NSString* seller = [dToAccess objectForKey:@"sellername"];//
    NSString* email = [dToAccess objectForKey:@"selleremail"];
    NSInteger listID = [[dToAccess objectForKey:@"listid" ] integerValue];//
   
    cell.tag = listID;
    
    cell.title = title;
    cell.author = [NSString stringWithFormat:@"Author: %@", author];
    cell.edition = [NSString stringWithFormat:@"Edition: %ld", (long) [edition integerValue]];
    cell.ISBN = [NSString stringWithFormat:@"%ld", (long) [ISBN integerValue]];
    cell.sname = seller;
    cell.semail = email;
    
    
//    NSLog(@"#######cell ISBN is: %@", ISBN);
    cell.binding = binding;
    //cell.bookID = [bookID integerValue];

    cell.price.text = [NSString stringWithFormat:@"$%@", price];
    cell.condition.text = condition;
    [cell.seller setTitle:seller forState:UIControlStateNormal];
    [cell.seller setTitle:seller forState:UIControlStateSelected];
    
    if(self.displayingUserListings) {
        // If you're viewing your own listings, no need to display your name
        [cell.seller setTitle:@"" forState:UIControlStateNormal];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(150, 11,150, 21);
        [button setTitle:@"Remove Listing!" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.adjustsImageWhenHighlighted = YES;
    
        button.tag = listID; //this is my current hack to add the id but no dice :(
    
        [button addTarget:self action:@selector(deleteListing:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMBListingCell *cell = (CMBListingCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    self.bookTitleToSend = cell.title;
    //   self.bookTitleToSend = @"HELP ME";
    self.bookAuthorToSend = cell.author;
    self.bookEditionToSend = cell.edition;
    self.bookISBNToSend = cell.ISBN;
    self.bookBindingToSend = cell.binding;
  //  self.bookIDToSend = cell.bookID;
    self.bookPriceToSend = cell.price.text;
   // self.bookConditionToSend = cell.condition.text;
    self.sellerNameToSend = cell.sname;
    self.sellerEmailToSend = cell.semail;
    NSLog(@"*****Seller Name is: %@", self.sellerNameToSend);
    NSLog(@"*****Seller Email is: %@", self.sellerEmailToSend);
    
    [self performSegueWithIdentifier:@"listingsToListing" sender:indexPath];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"listingsToListing"]) {
        CMBListingViewController *controller = (CMBListingViewController *)segue.destinationViewController;
        
        controller.bookName = self.bookTitleToSend;
        controller.bookAuthor = self.bookAuthorToSend;
        controller.bookEdition = self.bookEditionToSend;
        controller.bookISBN = self.bookISBNToSend;
 //       NSLog(@"#######Book ISBN is: %@", self.bookISBNToSend);
        controller.bookBinding = self.bookBindingToSend;
        controller.bookPrice = self.bookPriceToSend;
     //   controller.condition = self.bookConditionToSend;
        controller.bookStatus = self.bookStatusToSend;
 //       NSLog(@"!!!!!!!!Book title is: %@", self.bookTitleToSend);
        controller.sellerName = self.sellerNameToSend;
        controller.sellerEmail = self.sellerEmailToSend;
        
        NSLog(@"%s", "Gets past prepare for segue in CMBListingsTableViewController");
    }
}

@end
