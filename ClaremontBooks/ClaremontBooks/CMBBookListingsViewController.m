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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData]; // to reload selected cell
}

- (void)viewDidLoad
{
    [self reloadView];
}

-(void)reloadView {
    self.title = @"Choose Book";
    
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
    
    
    NSLog(@"%@", [_books objectAtIndex:_books.count-1 ]);
    
    // Initialize the filteredBookArray with a capacity equal to the  book array's capacity
    self.filteredBookArray = [NSMutableArray arrayWithCapacity:[_books count]];
    
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

- (CMBBookCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCell";
    CMBBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[CMBBookCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    NSDictionary *dToAccess = (self.tableView==tableView)?[self.books objectAtIndex:indexPath.row] : [self.filteredBookArray objectAtIndex:indexPath.row];
    
    NSString* title = [dToAccess objectForKey:@"title"];
    NSString* author = [dToAccess objectForKey:@"author"];
    NSNumber* edition = [dToAccess objectForKey:@"edition"];
    NSNumber* ISBN = [dToAccess objectForKey:@"isbn"];
    NSString* binding = [dToAccess objectForKey:@"binding"];
    NSNumber* bookID = [dToAccess objectForKey:@"bookid"];
    
    cell.title = title;
    cell.author = author;
    cell.edition = [NSString stringWithFormat:@"%ld", (long) [edition integerValue]];
    cell.ISBN = [NSString stringWithFormat:@"%ld", (long) [ISBN integerValue]];
    cell.binding = binding;
    cell.bookID = [bookID integerValue];
    
    cell.textLabel.text = [NSString stringWithFormat: @"%@ (Ed. %@)", title, edition];
    cell.detailTextLabel.text = [NSString stringWithFormat: @"by %@", author];
    

    NSLog(@"%@", author);
    
    return cell;
}
    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMBBookCell *cell = (CMBBookCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    self.bookTitleToSend = cell.title;
    self.bookAuthorToSend = cell.author;
    self.bookEditionToSend = cell.edition;
    self.bookISBNToSend = cell.ISBN;
    self.bookBindingToSend = cell.binding;
    self.bookIDToSend = cell.bookID;
    NSLog(@"%@", @"gets here");
    [self performSegueWithIdentifier:@"bookListToBookView" sender:indexPath];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText {
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"bookListToBookView"]){
        CMBBookViewController *controller = (CMBBookViewController *)segue.destinationViewController;
        controller.bookName = self.bookTitleToSend;
        controller.bookAuthor = self.bookAuthorToSend;
        controller.bookEdition = self.bookEditionToSend;
        controller.bookISBN = self.bookISBNToSend;
        controller.bookBinding = self.bookBindingToSend;
        controller.bookID = self.bookIDToSend;
        controller.userID = self.userID;
    }
}


@end
