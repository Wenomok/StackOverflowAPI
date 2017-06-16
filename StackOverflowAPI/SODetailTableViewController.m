//
//  SODetailTableViewController.m
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "SODetailTableViewController.h"
#import "SOQuestion.h"
#import "SODetailTableViewCell.h"
#import "SOAnswer.h"
#import "UIColor+StackOverflow.h"
#import "NSMutableAttributedString+StackOverflow.h"

@interface SODetailTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SODetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailConnection = [[SOConnection alloc] init];
    self.answersDetail = [NSArray arrayWithArray:[self.detailConnection connectFromDetailTableToAPIWithIdQuestion:self.idQuestionDetail]];
    
    SOQuestion *question = [[SOQuestion alloc] init];
    question.autorQuestion = self.autorDetail;
    question.idQuestion = self.idQuestionDetail;
    question.lastEditDateQuestion = self.lastEditDateDetail;
    question.scoreQuestion = self.scoreDetail;
    question.detailAttributedBody = self.detailAttributedBodyQuestion;
    
    self.questionDetail = [NSArray arrayWithObject:question];
    
    self.questionAndAnswers = @{@"1Question" : self.questionDetail,
                            @"2Answers" : self.answersDetail};
    self.questionAndAnswersSectionTitle = [self.questionAndAnswers allKeys];
    
    self.refresh = [[UIRefreshControl alloc] init];
    [self.refresh addTarget:self action:@selector(topRefresh) forControlEvents:UIControlEventValueChanged];
    
    self.detailTableView.refreshControl = self.refresh;
}

#pragma mark - Refresh

- (void)topRefresh
{
    [self.refresh beginRefreshing];
    self.answersDetail = [NSArray arrayWithArray:[self.detailConnection connectFromDetailTableToAPIWithIdQuestion:self.idQuestionDetail]];
    self.questionAndAnswers = @{@"1Question" : self.questionDetail,
                                @"2Answers" : self.answersDetail};
    [self.detailTableView reloadData];
    
    [self.refresh endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.questionAndAnswersSectionTitle count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [self.questionAndAnswersSectionTitle objectAtIndex:section];
    NSArray *sectionQuestionAndAnswers = [self.questionAndAnswers objectForKey:sectionTitle];
    return [sectionQuestionAndAnswers count];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SODetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableCell" forIndexPath:indexPath];

    NSString *sectionTitle = [self.questionAndAnswersSectionTitle objectAtIndex:indexPath.section];
    NSArray *sectionQuestionAndAnswers = [self.questionAndAnswers objectForKey:sectionTitle];
    
    if(indexPath.section == 0) {
        SOQuestion *question = [sectionQuestionAndAnswers objectAtIndex:indexPath.row];
        cell.idQuestionLabel.text = [NSString stringWithFormat:@"%@", question.idQuestion];
        cell.autorLabel.text = question.autorQuestion;
        cell.dateLabel.text = question.lastEditDateQuestion;
        cell.scoreLabel.text = [NSString stringWithFormat:@"%@", question.scoreQuestion];
        cell.bodyTextLabel.attributedText = question.detailAttributedBody;
        cell.backgroundColor = [UIColor soBrownColor];
    }
    
    if(indexPath.section != 0) {
        SOAnswer *answer = [sectionQuestionAndAnswers objectAtIndex:indexPath.row];
        answer.detailAttributedBodyAnswer = [NSMutableAttributedString configuredSOStringWithString:answer.bodyTextAnswer];
        cell.idQuestionLabel.hidden = YES;
        cell.autorLabel.text = answer.autorAnswer;
        cell.bodyTextLabel.attributedText = answer.detailAttributedBodyAnswer;
        cell.scoreLabel.text = [NSString stringWithFormat:@"%@", answer.scoreAnswer];
        cell.dateLabel.text = answer.lastActivityDateAnswer;
        cell.backgroundColor = [UIColor whiteColor];
        cell.okImage.image = nil;
        if([answer.isAccepted isEqualToString:@"1"]) {
            cell.okImage.image = [UIImage imageNamed:@"OK"];
            cell.backgroundColor = [UIColor soLightGreenColor];
        }
    }
    return cell;
}

@end
