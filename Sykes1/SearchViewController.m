//
//  SearchViewController.m
//  Sykes1
//
//  Created by Ronald F. Paglinawan on 8/3/14.
//  Copyright (c) 2014 Bonafide Infotech Inc. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UIScrollViewDelegate>
{
    UIActivityIndicatorView *progressIndicator;
    NSTimer *timey;
}

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;
@property (strong, nonatomic) NSMutableArray *searchResults;

@end

@implementation SearchViewController

static NSString *SearchCell = @"SearchCell";

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
    self.navigationController.navigationBar.hidden = NO;
    
    NSLog(@"queryString: %@", _queryString);
    
    
    // initialize the activity indicator
    progressIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *itemIndicator = [[UIBarButtonItem alloc] initWithCustomView:progressIndicator];
    [self.navigationItem setRightBarButtonItem:itemIndicator];

    
    // set the timer
    timey = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(loading) userInfo:Nil repeats:YES];

    
    
    // set searchBar text
    _searchBar.text = _queryString;
    
    if (_searchBar.text.length <= 3)
    {
        [self resetSearch];
        
        [progressIndicator stopAnimating];
        
    }
    
    else
    {
        [self performSearch];
        
        [progressIndicator startAnimating];
    }
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    // Show Keyboard
    // [self.searchBar becomeFirstResponder];
    // [self.nameTextField becomeFirstResponder];
    
    // Textfield Move Up
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loading
{
    if (_searchBar.text.length <= 3)
    {
        // do nothing
    }
    
    else
    {
        // do nothing
    }
}

// session getter method
- (NSURLSession *)session
{
    if (!_session)
    {
        // Initialize Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        // Configure Session Configuration
        [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json" }];
        
        // Initialize Session
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    
    return _session;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (!searchText) return;
    
    if (searchText.length <= 3)
    {
        [self resetSearch];
        
        [progressIndicator stopAnimating];
    }
    
    else
    {
        [self performSearch];
        
        [progressIndicator startAnimating];
    }
}

- (void)resetSearch
{
    // Update Data Source
    [self.searchResults removeAllObjects];
    
    // Update Table View
    [self.tableView reloadData];
}

- (void)performSearch
{
    NSString *query = self.searchBar.text;
    
    if (self.dataTask)
    {
        [self.dataTask cancel];
    }
    
    self.dataTask = [self.session dataTaskWithURL:[self urlForQuery:query] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                     {
                         if (error)
                         {
                             if (error.code != -999)
                             {
                                 NSLog(@"%@", error);
                             }
                             
                         }
                         
                         else
                         {
                             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                             NSArray *results = [result objectForKey:@"results"];
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 if (results)
                                 {
                                     [self processResults:results];
                                 }
                             });
                         }
                     }];
    
    if (self.dataTask)
    {
        [self.dataTask resume];
    }
}

- (NSURL *)urlForQuery:(NSString *)query
{
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?media=podcast&entity=podcast&term=%@", query]];
}

- (void)processResults:(NSArray *)results
{
    if (!self.searchResults)
    {
        self.searchResults = [NSMutableArray array];
    }
    
    // Update Data Source
    [self.searchResults removeAllObjects];
    [self.searchResults addObjectsFromArray:results];
    
    // Update Table View
    [self.tableView reloadData];
    
    
    [progressIndicator stopAnimating];
}


#pragma mark - UITableViewDataSource protocols
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.searchResults ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults ? self.searchResults.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCell forIndexPath:indexPath];
    
    // Fetch Search Results
    NSDictionary *resultsDictionary = [self.searchResults objectAtIndex:indexPath.row];
    
    // Configure Table View Cell
    [cell.textLabel setText:[resultsDictionary objectForKey:@"collectionName"]];
    [cell.detailTextLabel setText:[resultsDictionary objectForKey:@"artistName"]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - UITableViewDelegate protocols
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
     // Fetch Search Results
     NSDictionary *resultsDictionary = [self.searchResults objectAtIndex:indexPath.row];
     
     // Update User Defaults
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
     [ud setObject:resultsDictionary forKey:@"searchFile"];
     [ud synchronize];
     
     // Dismiss View Controller
     [self dismissViewControllerAnimated:YES completion:nil];
     */
    
    
    // Codes here to tell which cell is chosen and what file to open
}



#pragma mark - UIScrollViewDelegate protocols
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.searchBar isFirstResponder])
    {
        [self.searchBar resignFirstResponder];
        NSLog(@"SearchBar just resigned FirstResponder");
    }
    
    else if ([self.nameTextField isFirstResponder])
    {
        [self.nameTextField resignFirstResponder];
        NSLog(@"NameTextField just resigned FirstResponder");
    }
}

/*
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 {
 UITouch *touch = [[event allTouches] anyObject];
 
 if ([_nameTextField isFirstResponder] && [touch view] != _nameTextField)
 {
 [_nameTextField resignFirstResponder];
 
 NSLog(@"whos responder: %i", [_nameTextField isFirstResponder] );
 }
 
 else
 {
 // Unknown status. Do nothing.
 
 NSLog(@"else shit");
 }
 
 [super touchesBegan:touches withEvent:event];
 }*/


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTextField resignFirstResponder];
    NSLog(@"NameTextField just resigned FirstResponder");
    
    return YES;
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

#pragma mark - Textfield Move Up

- (void)keyboardDidShow:(NSNotification *)notification
{
    
    if ([_searchBar isFirstResponder])
    {
        [_searchBar becomeFirstResponder];
        NSLog(@"SearchBar just became the first responder");
    }
    
    else if  ([_nameTextField isFirstResponder])
    {
        [_nameTextField becomeFirstResponder];
        NSLog(@"NameTextField just became the first responder");
        
        //Assign new frame to your view
        [self.view setFrame:CGRectMake(0,-215,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
        
    }
    
    else
    {
        // Do nothing
    }
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,320,460)];
    
    [_nameTextField resignFirstResponder];
    NSLog(@"NameTextField just resigned FirstResponder");
}



@end
