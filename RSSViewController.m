//
//  RSSViewController.m
//  Tabs
//
//  Created by Dina Li on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSViewController.h"
//#import "RSSDetailViewController.h"

@interface RSSViewController ()

@end

@implementation RSSViewController

Parser *xmlParser;

-(void) viewWillAppear:(BOOL)animated
{
    self.title = @"Display Content from Website";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // NSString *urlString = @"http://ers.usda.gov/rss/calendar.aspx?type=topic&&n=1685";
    NSString *urlString = @"http://api.ers.usda.gov/REST/v1/topics/all";
   
    // note: some of the other ers topics do not have the description completed, so that results in a blank white screen!!
    
    xmlParser = [[Parser alloc] loadXMLByURL:urlString];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [[xmlParser recordsArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"FeedCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	Record *currentRecord = [[xmlParser recordsArray] objectAtIndex:(indexPath.row)];
    
    cell.textLabel.text = currentRecord.titleString;
    cell.detailTextLabel.text = currentRecord.linkString;
    
    return cell;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showFeed"]) {
//        
//        NSInteger row = [[self tableView].indexPathForSelectedRow row];
//        
//        Record *currentRecord = [[xmlParser recordsArray] objectAtIndex:(row)];
//        
//        RSSDetailViewController *detailController = segue.destinationViewController;
//        detailController.detailItem = currentRecord;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end
