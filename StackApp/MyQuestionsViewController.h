//
//  MyQuestionsViewController.h
//  StackApp
//
//  Created by Theodore Abshire on 12/9/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQuestionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *table;
-(void)reloadMy;

@end
