//
//  MainSOTableViewController.m
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "SOMainTableViewController.h"
#import "SOConnection.h"
#import "SOMainTableViewCell.h"
#import "SOQuestion.h"
#import "SODetailTableViewController.h"
#import "NSMutableAttributedString+StackOverflow.h"
#import "SOMenuTableViewController.h"
#import "AppDelegate.h"
#import "GTMNSString+HTML.h"
#import "NSString+HTML.h"
#import "AppDelegate.h"

@interface SOMainTableViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation SOMainTableViewController

// Все комментарии ниже относятся к пикеру
// При добавлении бокового меню, пикер более не нужен, но я хотел бы оставить его, чтобы иметь пример его создания и использования

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate *delegate = [[AppDelegate alloc] init];
//    self.managedObjectContext = delegate.persistentContainer.viewContext;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = delegate.persistentContainer.viewContext;
    
    self.page = 1;
    self.tags = [[NSArray alloc] initWithObjects:@"Objective-C", @"xCode", @"iOS", @"Cocoa-Touch", @"iPhone", nil];

    //    self.navigationItem.title = [self.tags objectAtIndex:0];
    
    self.questionsForTable = [[NSMutableArray alloc] initWithCapacity:50];
    
    self.tagsPicker.delegate = self;
    self.tagsPicker.showsSelectionIndicator = YES;
    self.tagsPicker.hidden = YES;
    self.tagsPicker.backgroundColor = [UIColor grayColor];
    
    self.mainConnection = [[SOConnection alloc] init];
    
//    self.questionsForTable = [NSMutableArray arrayWithArray:[self.mainConnection connectFromMainTableToAPIWithTag:self.tags.firstObject andPage:1]];
    
    if(self.senderTag == nil) {
        self.senderTag = @"Objective-C";
    }
    self.navigationItem.title = self.senderTag;
    [self connectToSOAPIWithTag:self.senderTag andPage:self.page];
    
//    if(self.senderTag != nil) {
//        self.navigationItem.title = self.senderTag;
////        self.questionsForTable = [NSMutableArray arrayWithArray:[self.mainConnection connectFromMainTableToAPIWithTag:self.senderTag andPage:self.page]];
//        [self connectToSOAPIWithTag:self.senderTag andPage:self.page];
//    } else {
//        self.navigationItem.title = [self.tags firstObject];
//        [self connectToSOAPIWithTag:[self.tags firstObject] andPage:self.page];
        //[self.mainConnection connectFromMainTableToAPIWithTag:[self.tags firstObject] andPage:self.page andBlock:blockForParseJSON];
//        self.questionsForTable = [NSMutableArray arrayWithArray:[self.mainConnection connectFromMainTableToAPIWithTag:[self.tags firstObject] andPage:self.page]];
//    }
    

    //START OF TEST CODE HERE
    
 /*
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *homeDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSError *error;
    
    NSString *filePath = [homeDirectory stringByAppendingPathComponent:@"file2.txt"];
    
    NSLog(@"%@", filePath);
    
    NSArray *test = @[@"hi", @",",@" great ", @"day", @"!"];
    
    [test writeToFile:filePath atomically:YES];
    
    NSData *dataOfFile = [[NSData alloc] initWithContentsOfFile:filePath];
    
    
    NSString *filePathToo = [homeDirectory stringByAppendingString:@"file3.txt"];
    [fileManager createFileAtPath:filePathToo contents:dataOfFile attributes:nil];
    
    NSString *readTextOnFile = [[NSString alloc] initWithContentsOfFile:filePathToo encoding:NSUTF8StringEncoding error:&error];
    
    NSString *str = [[NSString alloc] initWithData:dataOfFile encoding:NSUTF8StringEncoding];
    
    NSLog(@"Text of file: %@", [fileManager contentsAtPath:filePathToo]);
    
    if([fileManager isDeletableFileAtPath:filePathToo]) {
        [fileManager removeItemAtPath:filePathToo error:&error];
    }
    [fileManager removeItemAtPath:filePath error:&error];
    
    
    readTextOnFile = [[NSString alloc] initWithContentsOfFile:filePathToo encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", [fileManager contentsAtPath:filePathToo]);
  */
    
//    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"myDefaults"];
//    NSDictionary *testDictionary = @{@"Quetion?" : @"Question?",
//                                     @"Kek?" : @"Kek"};
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [userDefaults setObject:@"Kek" forKey:@"Name"];
//    [userDefaults setInteger:20 forKey:@"Age"];
//    [userDefaults setBool:YES forKey:@"Kek?"];
//    [userDefaults setValuesForKeysWithDictionary:testDictionary];
//    
//    NSString *homeDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *pathToPlist = [homeDirectory stringByAppendingPathComponent:@"defaults.plist"];
    
    
//    [fileManager createFileAtPath:pathToPlist contents:nil attributes:nil];
    
    //END OF TEST CODE HERE
    
    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh addTarget:self action:@selector(topRefresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.refreshControl = self.refresh;
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if(revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)insertNewObjectIntoData:(id)sender
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    SOQuestionDataModel *newQuestion = [[SOQuestionDataModel alloc] initWithContext:context];
    
    newQuestion = sender;
}

- (NSFetchedResultsController<SOQuestionDataModel *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"SOQuestionDataModel"];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:50];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastEditDateQuestion" ascending:NO];
//
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<SOQuestionDataModel *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:@"MASTER"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - Actions

- (void)connectToSOAPIWithTag:(NSString *)tag andPage:(int)page
{
    void (^blockForParseJSON)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if([NSJSONSerialization isValidJSONObject:json]) {
            
            NSArray *items = [json objectForKey:@"items"];
            
            [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
             {
                 NSDictionary *owner = [obj objectForKey:@"owner"];
                 
                 SOQuestion *question = [[SOQuestion alloc] initWithAutor:[[owner objectForKey:@"display_name"] stringByDecodingHTMLEntities]
                                                                  andDate:[obj objectForKey:@"last_activity_date"]
                                                                 andCount:[obj objectForKey:@"answer_count"]
                                                                 andTitle:[[obj objectForKey:@"title"] stringByDecodingHTMLEntities]
                                                                    andId:[obj objectForKey:@"question_id"]
                                                              andBodyText:[[obj objectForKey:@"body"] stringByDecodingHTMLEntities]
                                                                 andScore:[obj objectForKey:@"score"]];
                 [self.questionsForTable addObject:question];
                 //[self insertNewObjectIntoData:question];
             }
             ];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
//            if(self.questionsForTable != nil)
//                for(SOQuestion *question in self.questionsForTable) {
//                    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//                    SOQuestionDataModel *newQuestion = [[SOQuestionDataModel alloc] initWithContext:context];
//                    
//                    newQuestion.idQuestion = question.idQuestion;
//                    newQuestion.autorQuestion = question.autorQuestion;
//                    newQuestion.lastEditDateQuestion = question.lastEditDateQuestion;
//                    newQuestion.answerCountQuestion = question.answerCountQuestion;
//                    newQuestion.titleQuestion = question.titleQuestion;
//                    newQuestion.bodyTextQuestion = question.bodyTextQuestion;
//                    newQuestion.scoreQuestion = question.scoreQuestion;
//                }
            [self.tableView reloadData];
        });
    };
    [self.mainConnection connectFromMainTableToAPIWithTag:tag andPage:page andBlock:blockForParseJSON];
}

- (IBAction)tagIsPressed:(id)sender
{
    self.tagsPicker.hidden = NO;
}

#pragma mark - Refresh

- (void)topRefresh
{
    [self.refresh beginRefreshing];
//    NSInteger selectedTag = [self.tagsPicker selectedRowInComponent:0];
//    self.questionsForTable = [NSMutableArray arrayWithArray:[self.mainConnection connectFromMainTableToAPIWithTag:self.tags[selectedTag] andPage:1]];
//    self.questionsForTable = [NSMutableArray arrayWithArray:[self.mainConnection connectFromMainTableToAPIWithTag:self.senderTag andPage:1 andBlock:block]];
//    if(self.senderTag != nil) {
        [self connectToSOAPIWithTag:self.senderTag andPage:1];
//    }
//    else {
//        [self connectToSOAPIWithTag:[self.tags firstObject] andPage:1];
//    }
    for(SOQuestion *question in self.questionsForTable) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        SOQuestionDataModel *newQuestion = [[SOQuestionDataModel alloc] initWithContext:context];
    
        newQuestion.idQuestion = question.idQuestion;
        newQuestion.autorQuestion = question.autorQuestion;
        newQuestion.lastEditDateQuestion = question.lastEditDateQuestion;
        newQuestion.answerCountQuestion = question.answerCountQuestion;
        newQuestion.titleQuestion = question.titleQuestion;
        newQuestion.bodyTextQuestion = question.bodyTextQuestion;
        newQuestion.scoreQuestion = question.scoreQuestion;
        NSLog(@"%@", newQuestion);
    }
    
    NSArray<SOQuestionDataModel *> *array = [self.fetchedResultsController fetchedObjects];
    NSLog(@"%@", array);
    
    [self.tableView reloadData];
    
    [self.refresh endRefreshing];
}

#pragma mark - Scroll table view

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.tagsPicker.hidden = YES;
//    NSInteger selectedTag = [self.tagsPicker selectedRowInComponent:0];
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - self.tableView.frame.size.height;
    if(actualPosition == contentHeight) {
        self.page++;
//        if(self.senderTag != nil) {
            [self connectToSOAPIWithTag:self.senderTag andPage:self.page];
//        }
//        else {
//            [self connectToSOAPIWithTag:[self.tags firstObject] andPage:self.page];
//        }
//        [self.questionsForTable addObjectsFromArray:[self.mainConnection connectFromMainTableToAPIWithTag:self.tags[selectedTag] andPage:self.page]];
//        [self.questionsForTable addObjectsFromArray:[self.mainConnection connectFromMainTableToAPIWithTag:self.senderTag andPage:self.page]];
        [self.tableView reloadData];
        [self.activityIndicatorCell.downRefresh stopAnimating];
    }
}

#pragma mark - Picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.tags count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.tags objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.page = 1;
    self.questionsForTable = nil;
    self.mainConnection = [[SOConnection alloc] init];
//    self.questionsForTable = [NSMutableArray arrayWithArray:[self.mainConnection connectFromMainTableToAPIWithTag:self.tags[row] andPage:self.page]];
    self.navigationItem.title = [self.tags objectAtIndex:row];
    self.tagsPicker.hidden = YES;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([self.questionsForTable count] + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastCell = [self.questionsForTable count];
    if(indexPath.row == lastCell) {
        self.activityIndicatorCell = [tableView dequeueReusableCellWithIdentifier:@"ActivityIndicatorCell" forIndexPath:indexPath];
        
        [self.activityIndicatorCell.downRefresh startAnimating];
        
        return self.activityIndicatorCell;
    }
    
    SOMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableCell" forIndexPath:indexPath];
    
    //SOQuestionDataModel *qQuestion = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //NSLog(@"%@", qQuestion);
    
    SOQuestion *question = self.questionsForTable[indexPath.row];
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:question.titleQuestion];
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Chalkduster" size:15] range:NSMakeRange(0, [question.titleQuestion length])];
    
    cell.autorLabel.text = question.autorQuestion;
    cell.titleLabel.attributedText = attributedTitle;
    cell.lastEditDateLabel.text = question.lastEditDateQuestion;
    cell.idLabel.text = [NSString stringWithFormat:@"%@", question.idQuestion];
    cell.answerCountLabel.text = [NSString stringWithFormat:@"%@", question.answerCountQuestion];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.tagsPicker.hidden = YES;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SODetailTableViewController *detailTable = [segue destinationViewController];
    
    SOQuestion *question = [self.questionsForTable objectAtIndex:indexPath.row];
    
    question.detailAttributedBody = [NSMutableAttributedString configuredSOStringWithString:question.bodyTextQuestion];
    
    detailTable.idQuestionDetail = question.idQuestion;
    detailTable.autorDetail = question.autorQuestion;
    detailTable.lastEditDateDetail = question.lastEditDateQuestion;
    detailTable.scoreDetail = question.scoreQuestion;
    detailTable.detailAttributedBodyQuestion = question.detailAttributedBody;
}



@end
