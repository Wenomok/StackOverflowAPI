//
//  SOMenuTableViewController.m
//  StackOverflowAPI
//
//  Created by Vladislav on 05.05.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "SOMenuTableViewController.h"
#import "SOMainTableViewController.h"

@interface SOMenuTableViewController ()

@end

@implementation SOMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tags = @[@"Objective-C", @"iOS", @"xCode", @"Cocoa-Touch", @"iPhone"];
    self.currentTag = [NSString stringWithString:[self.tags firstObject]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.tags objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    self.currentTag = [NSString stringWithString:[self.tags objectAtIndex:indexPath.row]];
    UINavigationController *destController = [segue destinationViewController];
    SOMainTableViewController *main = [destController childViewControllers].firstObject;
    main.senderTag = self.currentTag;
}

@end
