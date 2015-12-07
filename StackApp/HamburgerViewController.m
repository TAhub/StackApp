//
//  HamburgerViewController.m
//  StackApp
//
//  Created by Theodore Abshire on 12/7/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "HamburgerViewController.h"

#define HAMBURGER_HEIGHT 50
#define HAMBURGER_HEIGHT_BUTTON 25
#define HAMBURGER_HEIGHT_EXTRA 5
#define HAMBURGER_SPEED 0.25
#define HAMBURGER_TITLE_1 @"Detail"
#define HAMBURGER_TITLE_2 @"Back"

@interface HamburgerViewController ()

@property (strong, nonatomic) UIViewController *meat;
@property (strong, nonatomic) UIViewController *cheese;
@property (strong, nonatomic) UIButton *button;

@end

@implementation HamburgerViewController

-(void)loadView
{
	[super loadView];
	
	//make the top bun
	self.button = [UIButton new];
	[self.button setTitle:HAMBURGER_TITLE_1 forState:UIControlStateNormal];
	[self.button setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.button setBackgroundColor:[UIColor redColor]];
	[self.view addSubview:self.button];
	[self.button addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
	NSDictionary *dict = [NSDictionary dictionaryWithObject:self.button forKey:@"button"];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%i-[button(==%i)]", HAMBURGER_HEIGHT - HAMBURGER_HEIGHT_BUTTON - HAMBURGER_HEIGHT_EXTRA, HAMBURGER_HEIGHT_BUTTON] options:0 metrics:nil views:dict]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-[button(>=%i)]", HAMBURGER_HEIGHT_BUTTON] options:0 metrics:nil views:dict]];
	
	//make the view controllers
	self.meat = [UIViewController new];
	self.cheese = [UIViewController new];
	
	self.meat.view.backgroundColor = [UIColor brownColor];
	self.cheese.view.backgroundColor = [UIColor yellowColor];
	
	//make the gesture recognizer
	UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideDetect:)];
	[swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
	[self.view addGestureRecognizer:swipe];
	
	swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideDetect:)];
	[swipe setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.view addGestureRecognizer:swipe];
}

-(void)slideDetect:(UISwipeGestureRecognizer *)sender
{
	switch (sender.direction)
	{
	case UISwipeGestureRecognizerDirectionLeft:
		if (self.cheese.parentViewController == self)
		{
			[self pressButton];
		}
		break;
	case UISwipeGestureRecognizerDirectionRight:
		if (self.meat.parentViewController == self)
		{
			[self pressButton];
		}
		break;
	default: break;
	}
}

-(void)pressButton
{
	UIViewController *m = self.meat;
	UIViewController *c = self.cheese;
	UIView *v = self.view;
	UIButton *b = self.button;
	
	if (c.view.layer.animationKeys.count > 0 || m.view.layer.animationKeys.count > 0)
	{
		//it's already animating
		return;
	}
	
	//switch between views
	if (self.meat.parentViewController == self)
	{
		//switch to the cheese
		
		[m willMoveToParentViewController:nil];
		
		[self addChildViewController:c];
		c.view.frame = CGRectMake(-v.frame.size.width, HAMBURGER_HEIGHT, v.frame.size.width, v.frame.size.height - HAMBURGER_HEIGHT);
		[v addSubview:c.view];
		[c didMoveToParentViewController:self];
		
		[UIView animateWithDuration:HAMBURGER_SPEED animations:^(void)
		{
			c.view.frame = CGRectMake(0, HAMBURGER_HEIGHT, v.frame.size.width, v.frame.size.height - HAMBURGER_HEIGHT);
		} completion:^(BOOL success)
		{
			[m.view removeFromSuperview];
			[m removeFromParentViewController];
			[b setTitle:HAMBURGER_TITLE_2 forState:UIControlStateNormal];
		}];
		
	}
	else
	{
		//switch to the meat
		
		[c willMoveToParentViewController:nil];
		
		[self addChildViewController:m];
		m.view.frame = CGRectMake(0, HAMBURGER_HEIGHT, v.frame.size.width, v.frame.size.height - HAMBURGER_HEIGHT);
		[v addSubview:m.view];
		[v sendSubviewToBack:m.view];
		[m didMoveToParentViewController:self];
		
		[UIView animateWithDuration:HAMBURGER_SPEED animations:^(void)
		 {
			 c.view.frame = CGRectMake(-v.frame.size.width, HAMBURGER_HEIGHT, v.frame.size.width, v.frame.size.height - HAMBURGER_HEIGHT);
		 } completion:^(BOOL success)
		 {
			 [c.view removeFromSuperview];
			 [c removeFromParentViewController];
			 [b setTitle:HAMBURGER_TITLE_1 forState:UIControlStateNormal];
		 }];
	}
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	//the meat should be displayed, to start with
	[self addChildViewController:self.meat];
	self.meat.view.frame = CGRectMake(0, HAMBURGER_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - HAMBURGER_HEIGHT);
	[self.view addSubview:self.meat.view];
	[self.meat didMoveToParentViewController:self];
}

@end
