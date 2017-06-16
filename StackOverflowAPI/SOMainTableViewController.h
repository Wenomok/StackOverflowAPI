//
//  MainSOTableViewController.h
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOConnection.h"
#import "SOActivityIndicatorTableViewCell.h"
#import "AudioToolbox/AudioServices.h"
#import "SORevealViewController.h"
#import "SOMenuTableViewController.h"
#import "CoreData/CoreData.h"
#import "SOQuestionDataModel+CoreDataProperties.h"

@interface SOMainTableViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSMutableString *urlConnection;
@property (strong, nonatomic) NSMutableArray *questionsForTable;
@property (assign, nonatomic) int page;
@property (strong, nonatomic) NSMutableAttributedString *attributedBody;
@property (strong, nonatomic) NSString *senderTag;

@property (strong, nonatomic) SOConnection *mainConnection;
@property (strong, nonatomic) SOActivityIndicatorTableViewCell *activityIndicatorCell;

@property (strong, nonatomic) UIRefreshControl *refresh;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *tagsPicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (assign, nonatomic) SystemSoundID officeSound;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
