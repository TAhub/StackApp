//
//  OAuthViewController.h
//  StackApp
//
//  Created by Theodore Abshire on 12/7/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^oauthCompletion)();

@interface OAuthViewController : UIViewController

@property (copy, nonatomic) oauthCompletion completion;

@end
