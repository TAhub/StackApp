//
//  User.m
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "User.h"

@implementation User

-(nonnull id)initWithDisplayName:(NSString *)displayName profileImageURL:(NSURL *)profileImageURL link:(NSURL *)link reputation:(int)reputation userID:(int)userID acceptRate:(int)acceptRate
{
	if (self = [super init])
	{
		//initialize here
		_displayName = displayName;
		_profileImageURL = profileImageURL;
		_loadedImage = nil;
		_link = link;
		_reputation = reputation;
		_userID = userID;
		_acceptRate = acceptRate;
	}
	return self;
}

-(nonnull id)initFrom:(NSDictionary *)JSON
{
	if (self = [super init])
	{
		//initialize here
		_displayName = JSON[@"display_name"];
		_profileImageURL = JSON[@"profile_image"];
		_link = JSON[@"link"];
		_reputation = (int)JSON[@"reputation"];
		_userID = (int)JSON[@"user_id"];
		_acceptRate = (int)JSON[@"accept_rate"];
		_loadedImage = nil;
		
	}
	return self;
}

@end