//
//  CMBBookListingsViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBBookListingsViewController.h"

@interface CMBBookListingsViewController ()

@end

@implementation CMBBookListingsViewController

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
    self.title = @"Books";
    

    // Commented code is for creating a new thread to get info from web (getting info could take awhile).
    // Commented code doesn't work right now.
//    dispatch_async(dispatch_get_global_queue(
//                                             DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:
                     @"http://www.claremontbooks.com/books.php?show=json"]];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          
                          options:kNilOptions
                          error:&error];
    
    _books = [json objectForKey:@"books"]; //2
    
    // Initialize the filteredBookArray with a capacity equal to the  book array's capacity
    self.filteredBookArray = [NSMutableArray arrayWithCapacity:[_books count]];
    //self.filteredBookArray = nil;
        
        
        
//    });
    
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
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        return [_filteredBookArray count];
//    } else {
//        return [_books count];
//    }
    
    return (tableView==self.tableView)?self.books.count:self.filteredBookArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCell";
    CMBBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                                                        //forIndexPath:indexPath];
    
    if (cell==nil) {
        cell = [[CMBBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    NSDictionary *dToAccess = (self.tableView==tableView)?[self.books objectAtIndex:indexPath.row] : [self.filteredBookArray objectAtIndex:indexPath.row];
    
    NSString* title = [dToAccess objectForKey:@"title"];
    NSString* author = [dToAccess objectForKey:@"author"];
    NSNumber* edition = [dToAccess objectForKey:@"edition"];
    NSNumber* ISBN = [dToAccess objectForKey:@"ISBN"];
    NSString* binding = [dToAccess objectForKey:@"binding"];
    
    cell.textLabel.text = [NSString stringWithFormat: @"%@ (Ed. %@)", title, edition];
    cell.detailTextLabel.text = [NSString stringWithFormat: @"by %@", author];
    
    return cell;
}
    
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText {
                            //scope:(NSString*)scope {
    
    // Update the filtered array based on the search text and scope.
    
    
    // replace special characters
    NSString* fixedFormatting = searchText;
    
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"^" withString:@"%5E"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"}" withString:@"%7D"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@">" withString:@"%7E"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"`" withString:@"%80"];
    fixedFormatting = [fixedFormatting stringByReplacingOccurrencesOfString:@"$" withString:@"%24"];
    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:
                     [NSString stringWithFormat: @"http://www.claremontbooks.com/search.php?target=%@&show=json", fixedFormatting]]];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          
                          options:kNilOptions
                          error:&error];
    
    //NSLog([NSString stringWithFormat: @"%@",json]);
    
    _filteredBookArray = [json objectForKey:@"books"]; //2
    //NSLog([NSString stringWithFormat: @"%@", _filteredBookArray]);
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


@end
