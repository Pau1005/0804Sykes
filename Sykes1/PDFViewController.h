//
//  PDFViewController.h
//  Sykes1
//
//  Created by Ronald F. Paglinawan on 7/29/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface PDFViewController : UIViewController  <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *pdfWebView;

@property (strong, nonatomic) NSMutableArray *chosenItemsArray;

@property (strong, nonatomic) NSMutableArray *mediaItemsArray;
@property (strong, nonatomic) NSMutableArray *mentionItemsArray;
@property (strong, nonatomic) NSMutableArray *topicItemsArray;
@property (strong, nonatomic) NSMutableArray *attributeItemsArray;
@property (strong, nonatomic) NSMutableArray *productItemsArray;
@property (strong, nonatomic) NSMutableArray *keyFindingItemsArray;
@property (strong, nonatomic) NSString *researchTypeString;

- (IBAction)chooseAction:(id)sender;
@end
