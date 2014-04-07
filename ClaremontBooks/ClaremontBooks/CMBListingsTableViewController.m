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
    
    
    
    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:
                     @"http://www.claremontbooks.com/books.php?show=json"]];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          
                          options:kNilOptions
                          error:&error];
    
    _listings = [json objectForKey:@"listings"]; //2
    
    
    
    
    _listings = [json objectForKey:@"listings"];
    
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    NSString* seller = [listing objectForKey:@"seller"];
    NSString* email = [listing objectForKey:@"email"];
    
    
    
    cell.price.text = [NSString stringWithFormat:@"$%@", price];
    cell.condition.text = condition;
    [cell.seller setTitle:seller forState:UIControlStateNormal];
    [cell.seller setTitle:seller forState:UIControlStateSelected];
    
    return cell;
    
    
    
    
    
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

@end
