//
//  QuestionTableViewCell.h
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic) Question *question;


@end
