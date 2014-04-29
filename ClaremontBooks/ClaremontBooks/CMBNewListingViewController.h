//
//  CMBNewListingViewController.h
//  ClaremontBooks
//
//  Created by Chris on 2/24/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBNewListingViewController : UIViewController

@property (strong) IBOutlet UILabel *titleLabel;
@property (strong) IBOutlet UILabel *authorLabel;
@property (strong) IBOutlet UILabel *editionLabel;
@property (strong) IBOutlet UILabel *ISBNLabel;
@property (strong) IBOutlet UILabel *bindingLabel;
@property (strong) IBOutlet UILabel *conditionLabel; // Currently no condition
@property (strong) IBOutlet UILabel *priceLabel;
@property (strong) IBOutlet UILabel *statusLabel;

@property (nonatomic, retain) IBOutlet UIButton *sellerNameButton;
@property (nonatomic, retain) IBOutlet UIButton *selllerEmailButton;



@property (strong) NSString *bookName;
@property (strong) NSString *bookAuthor;
@property (strong) NSString *bookEdition;
@property (strong) NSString *bookISBN;
@property (strong) NSString *bookBinding;
@property (strong) NSString *bookPrice;
@property (strong) NSString *bookStatus;
@property (strong) NSString *sellerName;
@property (strong) NSString *sellerEmail;

@property NSInteger bookID;


@end
