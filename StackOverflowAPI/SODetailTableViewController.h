//
//  SODetailTableViewController.h
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOConnection.h"
#import "SOQuestion.h"
#import "AudioToolbox/AudioServices.h"

@interface SODetailTableViewController : UIViewController

@property (strong, nonatomic) NSNumber *idQuestionDetail;
@property (strong, nonatomic) NSString *autorDetail;
@property (strong, nonatomic) NSString *lastEditDateDetail;
@property (strong, nonatomic) NSNumber *scoreDetail;

@property (strong, nonatomic) UIRefreshControl *refresh;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSArray *answersDetail;
@property (strong, nonatomic) NSArray *questionDetail;
@property (strong, nonatomic) NSArray *questionAndAnswersSectionTitle;
@property (strong, nonatomic) NSDictionary *questionAndAnswers;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@property (strong, nonatomic) SOConnection *detailConnection;

@property (strong, nonatomic) NSMutableAttributedString *detailAttributedBodyQuestion;
@property (strong, nonatomic) NSMutableAttributedString *detailAttributedBodyAnswer;

@end
