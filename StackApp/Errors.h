//
//  Errors.h
//  StackApp
//
//  Created by Theodore Abshire on 12/7/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kStackAppErrorDomain;

typedef enum:NSUInteger
{
	StackAppFailedToLoadImage,
	StackAppBadJSON,
	StackAppConnectionDown,
	StackAppTooManyAttempts,
	StackAppInvalidParameter,
	StackAppNeedAuthentication,
	StackAppGeneralError
} StackAppErrorCodes;