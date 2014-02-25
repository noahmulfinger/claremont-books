//
//  CMBNewBookEntryViewController.m
//  ClaremontBooks
//
//  Created by Chris on 2/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "CMBNewBookEntryViewController.h"
#import "CMBNewBookEntryView.h"

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

//- (void) loadView
//{
//    CMBNewBookEntryView *view = [[CMBNewBookEntryView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//    self.view = view;
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) insert:(id)sender
{
    // create string contains url address for php file, the file name is phpFile.php, it reveives parameter :name
    //NSString *strURL = [NSString stringWithFormat:@"http://localhost/MAMP/phpFile.php?name=%@", _bookTitle.text];
    NSString *strURL = [NSString stringWithFormat:@"http://claremontbooks.com/insertBookMobile.php?bookTitle=%@&bookAuthor=%@&bookEdition=%@&bookISBN=%@&bookBinding=%@&password=secret", _bookTitle.text, _author.text, _edition.text, _ISBN.text, _binding.text];
    
    // to execute php code
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    
    // to reveive the returned value
    NSString *strResult = [[NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", strResult);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textViewDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    
    CGRect frame = self.view.frame;
    frame.origin.y = -100;
    [self.view setFrame:frame];
    
    [UIView commitAnimations];
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    
    CGRect frame = self.view.frame;
    frame.origin.y = 100;
    [self.view setFrame:frame];
    
    [UIView commitAnimations];
    
    return YES;
}

@end
