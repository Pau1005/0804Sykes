//
//  ReadMoreViewController.m
//  Sykes1
//
//  Created by Rhenz on 7/24/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import "ReadMoreViewController.h"

@interface ReadMoreViewController ()

@end

@implementation ReadMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set labels
    [self.serviceTitleButtonOutlet setTitle:_mainServiceString forState:UIControlStateNormal];
    self.mediaDetailLabel.text = _mediaTypeDetailString;
    self.mentionDetailLabel.text = _mentionDetailString;
    self.topicTrendsDetailLabel.text = _topicTrendsDetailString;
    self.attributeDetailLabel.text = _attributeDetailString;
    self.productSentimentDetailLabel.text = _productSentimentDetailString;
    self.keyFindingsDetailLabel.text = _keyFindingsDetailString;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serviceTitleButtonPressed:(id)sender
{
    [_serviceTitleButtonOutlet setShowsTouchWhenHighlighted:YES];
    [_serviceTitleButtonOutlet showsTouchWhenHighlighted];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
