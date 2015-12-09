//
//  QuestionTableViewCell.m
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "QuestionTableViewCell.h"
#import "StackWebService.h"

@implementation QuestionTableViewCell

-(void)setQuestion:(Question *)question
{
	self.title.text = question.title;
	self.name.text = (question.owner != nil ? question.owner.displayName : @"Unknown");
	
	//load the image
	self.image.image = nil;
	if (question.owner != nil)
	{
		__weak typeof(self) weakSelf = self;
		[[StackWebService sharedService] fetchImageInBackgroundFromURL:question.owner.profileImageURL completionHandler:
		^(UIImage* _Nullable image, NSError* _Nullable error){
			if (error)
			{
				NSLog(@"%@", error);
			}
			else if (image)
			{
				weakSelf.image.image = image;
				question.owner.loadedImage = image;
			}
		}];
	}
}

@end
