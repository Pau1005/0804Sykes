//
//  HomeViewController.m
//  Sykes1
//
//  Created by Ronald F. Paglinawan on 8/3/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
    // clear searchField
    _searchField.text = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_searchField isFirstResponder] && [touch view] != _searchField)
    {
        [_searchField resignFirstResponder];
    }
    
    else
    {
        // Unknown status. Do nothing.
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_searchField resignFirstResponder];
    
    if ( _searchField.text == nil || _searchField.text.length <= 3 )
    {
        // display an alert view
        UIAlertView *alertDialog;
        
        alertDialog = [[UIAlertView alloc]
                       initWithTitle: @"Warning"
                       message:@"Please enter a text more than 3 characters before proceding."
                       delegate: self
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        [alertDialog show];
    }
    
    else
    {
        // perform Segue programmatically
        [self performSegueWithIdentifier:@"toSearchSegue" sender:self];
    }
    
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toSearchSegue"])
    {
        if ( _searchField.text == nil || _searchField.text.length <= 3 )
        {
            // display an alert view
            UIAlertView *alertDialog;
            
            alertDialog = [[UIAlertView alloc]
                           initWithTitle: @"Warning"
                           message:@"Please enter a text more than 3 characters."
                           delegate: self
                           cancelButtonTitle: @"Ok"
                           otherButtonTitles: nil];
            [alertDialog show];
        }
        
        else
        {
            // open SearchViewController
            SearchViewController *searchVC = [segue destinationViewController];
            [searchVC setQueryString:_searchField.text];
        }
    }
    
    else
    {
        // Do nothing.
    }
}


@end
