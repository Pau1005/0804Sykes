//
//  MediaTypeTableViewController.h
//  Sykes1
//
//  Created by Rhenz on 7/24/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MentionTypeTableViewController.h"

@interface MediaTypeTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *mediaTypeArray;

@property (strong, nonatomic) NSMutableArray *chosenItemsArray;

@property (strong, nonatomic) NSMutableArray *mediaItemsArray;

@property (strong, nonatomic) NSString *researchTypeString;

@end
