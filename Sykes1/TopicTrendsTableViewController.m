//
//  TopicTrendsTableViewController.m
//  Sykes1
//
//  Created by Rhenz on 7/24/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import "TopicTrendsTableViewController.h"

@interface TopicTrendsTableViewController ()
{
    int itemCounter;
    
    int choicesLimiterCounter;
}
@end

@implementation TopicTrendsTableViewController

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
    [super viewDidLoad];

    _topicTrendsArray = [NSArray arrayWithObjects:@"Brand Mention", @"Criticism", @"Complaint", @"Gratitude", @"Compliment", @"Marketing", @"Media Relations", @"News", @"Query", @"Review", @"Suggestion", @"Support", nil];
    
    // set itemCounter to 0
    itemCounter = 0;

    _topicItemsArray = [[NSMutableArray alloc] init];
    
    NSLog(@"researchTypeString: %@", _researchTypeString);
    
    if ([_researchTypeString isEqualToString:@"Essentials"])
    {
        // set choicesLimiterCounter to 5
        choicesLimiterCounter = 5;
    }
    
    else if ([_researchTypeString isEqualToString:@"Comprehensive"])
    {
        // set choicesLimiterCounter to 7
        choicesLimiterCounter = 7;
    }
    
    else if ([_researchTypeString isEqualToString:@"Industry"])
    {
        // set choicesLimiterCounter to 7
        choicesLimiterCounter = 7;
    }

    
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
    // Return the number of rows in the section.
    return [_topicTrendsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"topicTrendsCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [_topicTrendsArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    // Accessory Checkmark
    if ((cell.accessoryType == UITableViewCellAccessoryNone) && choicesLimiterCounter != 0)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        choicesLimiterCounter--;
        NSLog(@"choicesLimiterCounter: %d", choicesLimiterCounter);
        
        
        // save current cell textLabel value to chosenItemsArray:
        [_chosenItemsArray addObject:cell.textLabel.text];
        
        
        [_mediaItemsArray addObject:cell.textLabel.text];
        
        itemCounter++;
        
    }
    
    else if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        choicesLimiterCounter++;
        NSLog(@"choicesLimiterCounter: %d", choicesLimiterCounter);
        
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAttributeSentimentSegue"])
    {
        // open AttributeSentimentTableViewController
        AttributeSentimentTableViewController *attributeVC = [segue destinationViewController];
        [attributeVC setChosenItemsArray:_chosenItemsArray];
        
        [attributeVC setMediaItemsArray:_mediaItemsArray];
        [attributeVC setMentionItemsArray:_mentionItemsArray];
        [attributeVC setTopicItemsArray:_topicItemsArray];
        [attributeVC setResearchTypeString:_researchTypeString];
    }
}


@end
