//
//  SOMainTableViewCell.h
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOMainTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *autorLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastEditDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@end
