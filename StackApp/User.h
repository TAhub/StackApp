//
//  User.h
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User: NSObject

@property (strong, readonly, nonnull) NSString *displayName;
@property (strong, readonly, nonnull) NSURL *profileImageURL;
@property (strong, nonatomic, nullable) UIImage *loadedImage;
@property (strong, readonly, nonnull) NSURL *link;
@property int reputation;
@property int userID;
@property int acceptRate;

-(nonnull id)initWithDisplayName:(NSString* _Nonnull) displayName profileImageURL:(NSURL* _Nonnull)profileImageURL link:(NSURL* _Nonnull)link reputation:(int)reputation userID:(int)userID acceptRate:(int)acceptRate;
-(nonnull id)initFrom:(NSDictionary* _Nonnull)JSON;

@end