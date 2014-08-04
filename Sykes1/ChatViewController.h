//
//  ChatViewController.h
//  Sykes1
//
//  Created by Ronald F. Paglinawan on 8/3/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *commentField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)postComment:(id)sender;
@end
