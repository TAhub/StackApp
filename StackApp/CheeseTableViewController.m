//
//  CheeseTableViewController.m
//  StackApp
//
//  Created by Theodore Abshire on 12/7/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "CheeseTableViewController.h"
#import "HamburgerViewController.h"

@interface CheeseTableViewController ()

@end

@implementation CheeseTableViewController

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	//set the main meat to be selected by default
	HamburgerViewController *hamburger = (HamburgerViewController *)[self parentViewController];
	NSIndexPath *path = [NSIndexPath indexPathForRow:[hamburger activeMeat] inSection:0];
//	[self tableView:self.tableView didSelectRowAtIndexPath:path];
	[self.tableView selectRowAtIndexPath:path animated:false scrollPosition:UITableViewScrollPositionBottom];
}


#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	HamburgerViewController *hamburger = (HamburgerViewController *)[self parentViewController];
	[hamburger switchTo:(int)indexPath.row];
}

@end
