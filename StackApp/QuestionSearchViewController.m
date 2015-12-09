//
//  QuestionSearchViewController.m
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "Question.h"
#import "QuestionTableViewCell.h"
#import "StackWebService.h"

@interface QuestionSearchViewController () <UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *questions;

@end

@implementation QuestionSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.table.dataSource = self;
	self.field.delegate = self;
	[self.table registerNib:[UINib nibWithNibName:@"QuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - table view
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	QuestionTableViewCell *cell = (QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil)
	{
		//make a new one
		cell = [QuestionTableViewCell new];
	}
	
	cell.question = self.questions[indexPath.row];
	
	return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.questions.count;
}

#pragma mark - text field
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.field resignFirstResponder];
	
	NSLog(@"Searching...");
	
	//search for it!
	__weak typeof(self) weakSelf = self;
	
	[[StackWebService sharedService] search:self.field.text pageNumber:0 withCompletion:
	^(NSDictionary * _Nullable data, NSError * _Nullable error) {
		if (error == nil)
		{
			NSLog(@"Successful search!");
			
			weakSelf.questions = [NSMutableArray new];
			for (NSDictionary *JSON in (NSDictionary *)data)
			{
				[weakSelf.questions addObject:[[Question alloc] initFrom:JSON]];
			}
			
			[weakSelf.table reloadData];
		}
		else
		{
			NSLog(@"%@", error);
		}
	}];
	
	return true;
}

@end
