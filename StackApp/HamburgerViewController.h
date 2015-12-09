//
//  HamburgerViewController.h
//  StackApp
//
//  Created by Theodore Abshire on 12/7/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HamburgerViewController : UIViewController

@property (weak, nonatomic) UIViewController *meat;
-(void)switchTo:(int)controllerNum;
-(int)activeMeat;

@end
