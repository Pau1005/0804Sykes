//
//  KeyFindingsTableViewController.h
//  Sykes1
//
//  Created by Rhenz on 7/24/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "PDFViewController.h"


@interface KeyFindingsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *keyFindingsArray;

@property (strong, nonatomic) NSMutableArray *chosenItemsArray;

@property (strong, nonatomic) NSMutableArray *mediaItemsArray;
@property (strong, nonatomic) NSMutableArray *mentionItemsArray;
@property (strong, nonatomic) NSMutableArray *topicItemsArray;
@property (strong, nonatomic) NSMutableArray *attributeItemsArray;
@property (strong, nonatomic) NSMutableArray *productItemsArray;
@property (strong, nonatomic) NSMutableArray *keyFindingItemsArray;
@property (strong, nonatomic) NSString *researchTypeString;
@end
