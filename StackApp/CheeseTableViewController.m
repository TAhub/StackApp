//
//  CheeseTableViewController.m
//  StackApp
//
//  Created by Theodore Abshire on 12/7/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "CheeseTableViewController.h"
#import "HamburgerViewController.h"
#import "StackWebService.h"
#import "QuestionSearchViewController.h"
#import "MyQuestionsViewController.h"

@interface CheeseTableViewController ()

@end

@implementation CheeseTableViewController

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	//set the main meat to be selected by default
	HamburgerViewController *hamburger = (HamburgerViewController *)[self parentViewController];
	NSIndexPath *path = [NSIndexPath indexPathForRow:[hamburger activeMeat] inSection:0];
	[self.tableView selectRowAtIndexPath:path animated:false scrollPosition:UITableViewScrollPositionBottom];
	[self setOrderSortLabels];
}

-(void)setOrderSortLabels
{
	self.orderLabel.text = [NSString stringWithFormat:@"order: %@", [[StackWebService sharedService] orderType]];
	self.sortLabel.text = [NSString stringWithFormat:@"sort: %@", [[StackWebService sharedService] sortType]];
}

#pragma mark - table view delegate

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	HamburgerViewController *hamburger = (HamburgerViewController *)[self parentViewController];
	if (indexPath.row < 2)
	{
		[hamburger switchTo:(int)indexPath.row];
		return true;
	}
	else if (indexPath.row == 3)
		[[StackWebService sharedService] nextSort];
	else if (indexPath.row == 4)
		[[StackWebService sharedService] nextOrder];
	if (indexPath.row != 2)
	{
		[self setOrderSortLabels];
		
		//notify the cheese to reload
		if ([hamburger.meat isMemberOfClass:[QuestionSearchViewController class]])
			[(QuestionSearchViewController *)hamburger.meat reloadSearch];
		else if ([hamburger.meat isMemberOfClass:[MyQuestionsViewController class]])
			[(MyQuestionsViewController *)hamburger.meat reloadMy];
	}
	return false;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	HamburgerViewController *hamburger = (HamburgerViewController *)[self parentViewController];
//	if (indexPath.row < 2)
//	{
//		[hamburger switchTo:(int)indexPath.row];
//	}
//	else if (indexPath.row == 3)
//	{
//		
//	}
//	else if (indexPath.row == 4)
//	{
//		
//	}
}

@end
