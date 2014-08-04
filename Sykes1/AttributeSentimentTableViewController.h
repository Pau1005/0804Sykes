//
//  AttributeSentimentTableViewController.h
//  Sykes1
//
//  Created by Rhenz on 7/24/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSentimentTableViewController.h"

@interface AttributeSentimentTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *attributeSentimentArray;

@property (strong, nonatomic) NSMutableArray *chosenItemsArray;

@property (strong, nonatomic) NSMutableArray *mediaItemsArray;
@property (strong, nonatomic) NSMutableArray *mentionItemsArray;
@property (strong, nonatomic) NSMutableArray *topicItemsArray;
@property (strong, nonatomic) NSMutableArray *attributeItemsArray;
@property (strong, nonatomic) NSString *researchTypeString;
@end
