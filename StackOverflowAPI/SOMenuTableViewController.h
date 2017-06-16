//
//  SOMenuTableViewController.h
//  StackOverflowAPI
//
//  Created by Vladislav on 05.05.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOMenuTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *currentTag;

@end
