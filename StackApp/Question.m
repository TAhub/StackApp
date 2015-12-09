//
//  Question.m
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "Question.h"

@implementation Question

-(nonnull id)initWithTitle:(NSString *)title owner:(User *)owner questionID:(int)questionID viewCount:(int)viewCount score:(int)score isAnswered:(BOOL)isAnswered
{
	if (self = [super init])
	{
		//initialize here
		_title = title;
		_owner = owner;
		_questionID = questionID;
		_viewCount = viewCount;
		_score = score;
		_isAnswered = isAnswered;
	}
	return self;
}

-(nullable id)initFrom:(NSDictionary *)JSON
{
	if (self = [super init])
	{
		if (JSON == nil)
			return nil;
		
		//initialize here
		_title = (NSString *)JSON[@"title"];
		_owner = [[User alloc] initFrom:(NSDictionary *)JSON[@"owner"]];
		_questionID = (int)JSON[@"question_id"];
		_viewCount = (int)JSON[@"view_count"];
		_score = (int)JSON[@"score"];
		_isAnswered = (BOOL)JSON[@"is_answered"];
	}
	return self;
}

@end