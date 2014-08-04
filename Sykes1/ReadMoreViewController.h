//
//  ReadMoreViewController.h
//  Sykes1
//
//  Created by Rhenz on 7/24/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadMoreViewController : UIViewController <UIScrollViewDelegate>


// Sub-Services Details Labels
@property (strong, nonatomic) IBOutlet UILabel *mediaDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *mentionDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *topicTrendsDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *attributeDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *productSentimentDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *keyFindingsDetailLabel;
@property (strong, nonatomic) IBOutlet UIButton *serviceTitleButtonOutlet;

// Strings for Services' Details
@property (strong, nonatomic) NSString *mainServiceString;
@property (strong, nonatomic) NSString *mediaTypeDetailString;
@property (strong, nonatomic) NSString *mentionDetailString;
@property (strong, nonatomic) NSString *topicTrendsDetailString;
@property (strong, nonatomic) NSString *attributeDetailString;
@property (strong, nonatomic) NSString *productSentimentDetailString;
@property (strong, nonatomic) NSString *keyFindingsDetailString;

// Action to proceed to Quotation View Controller
- (IBAction)serviceTitleButtonPressed:(id)sender;


@end
