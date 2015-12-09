//
//  Question.h
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "User.h"

@interface Question: NSObject

@property (strong, readonly, nonnull) NSString *title;
@property (strong, readonly, nullable) User *owner;
@property int questionID;
@property int viewCount;
@property int score;
@property BOOL isAnswered;

-(nonnull id)initWithTitle:(NSString* _Nonnull)title owner:(User* _Nullable)owner questionID:(int)questionID viewCount:(int)viewCount score:(int)score isAnswered:(BOOL)isAnswered;
-(nullable id)initFrom:(NSDictionary* _Nullable)JSON;

@end