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
    
    
    // For now we hard code JSON info. Eventually, we will read it from web (once formatted correctly)
    NSString *jsonString = @"{\"books\":[{\"id\":\"71\",\"title\":\"Art of War\",\"author\":\"Sun Tzu\",\"ISPN\":\"2147483647\",\"binding\":\"Soft Cover\"},{\"id\":\"72\",\"title\":\"Reeses Mini\",\"author\":\"Peanut Butter cup\",\"ISPN\":\"987\",\"binding\":\"Edible\"},{\"id\":\"73\",\"title\":\"Design Patterns\",\"author\":\"Erich Gamma\",\"ISPN\":\"201633612\",\"binding\":\"Hard Cover\"}]}";
    //NSLog(@"%@", jsonString);
    NSError *error =  nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    
    
    
    _books = [json objectForKey:@"books"]; //2
    
    
    
    // Get info from www.claremontbooks.com
//    dispatch_async(dispatch_get_global_queue(
//                                             DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        [NSURL URLWithString:
//                         @"http://www.claremontbooks.com/books.php?show=json"]];
//        [self performSelectorOnMainThread:@selector(fetchedData:)
//                               withObject:data waitUntilDone:YES];
//    });
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
//    NSError* error;
//    NSDictionary* json = [NSJSONSerialization
//                          JSONObjectWithData:responseData //1
//                          
//                          options:kNilOptions
//                          error:&error];
    
    // For now we hard code JSON info. Eventually, we will read it from web (once formatted correctly)
    NSString *jsonString = @"{\"books\":[{\"id\":\"71\",\"title\":\"Art of War\",\"author\":\"Sun Tzu\",\"ISPN\":\"2147483647\",\"binding\":\"Soft Cover\"},{\"id\":\"72\",\"title\":\"Reeses Mini\",\"author\":\"Peanut Butter cup\",\"ISPN\":\"987\",\"binding\":\"Edible\"},{\"id\":\"73\",\"title\":\"Design Patterns\",\"author\":\"Erich Gamma\",\"ISPN\":\"201633612\",\"binding\":\"Hard Cover\"}]}";
    //NSLog(@"%@", jsonString);
    NSError *error =  nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];

    
    
    
    //_books = [json objectForKey:@"books"]; //2
    
    //NSLog(@"books: %@", json); //3
    
    
    
    
    
    // 1) Get the latest loan
//    NSDictionary* book = [_books objectAtIndex:0];
//    
//    // 2) Get the funded amount and loan amount
//    NSString* title = [book objectForKey:@"title"];
//    NSString* author = [book objectForKey:@"author"];
//    NSNumber* edition = [book objectForKey:@"edition"];
//    NSNumber* ISBN = [book objectForKey:@"ISBN"];
//    NSString* binding = [book objectForKey:@"binding"];
    
    
    
    //float outstandingAmount = [loanAmount floatValue] -
    //[fundedAmount floatValue];
    
    // 3) Set the label appropriately
    //_humanReadble.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
                          //[loan objectForKey:@"name"],
                          //[(NSDictionary*)[loan objectForKey:@"location"]
                          // objectForKey:@"country"],
                          //outstandingAmount];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //CMBBookObj *bookListing = [self.books objectAtIndex:indexPath.row];
    NSDictionary *book = [_books objectAtIndex:indexPath.row];
    
    NSString* title = [book objectForKey:@"title"];
    NSString* author = [book objectForKey:@"author"];
    NSNumber* edition = [book objectForKey:@"edition"];
    NSNumber* ISBN = [book objectForKey:@"ISBN"];
    NSString* binding = [book objectForKey:@"binding"];
    
    //cell.textLabel.text = bookListing.data.title;
    cell.textLabel.text = title;
    //cell.imageView.image = bookListing.thumbImage;
    
    // Configure the cell...
    
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
