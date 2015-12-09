//
//  StackWebService.h
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^kImageCompletion)(UIImage * _Nullable data , NSError  * _Nullable  error);
typedef void (^kDataCompletion)(NSData * _Nullable data , NSError  * _Nullable  error);
typedef void (^kDictionaryCompletion)(NSDictionary * _Nullable data , NSError  * _Nullable  error);
typedef void (^kImageFinishCompletion)();

@interface StackWebService: NSObject

+(nonnull id)sharedService;

-(void)fetchImageInBackgroundFromURL:(NSURL* _Nonnull)url completionHandler:(kImageCompletion _Nonnull)completionHandler;
-(void)registerImageFinish:(kImageFinishCompletion _Nonnull)completion;

-(void)getRequestWithURL:(NSString* _Nonnull)url parameters:(NSDictionary* _Nullable)parameters withCompletion:(kDataCompletion _Nonnull)completionHandler;
-(void)postRequestWithURL:(NSString* _Nonnull)url parameters:(NSDictionary* _Nullable)parameters withCompletion:(kDataCompletion _Nonnull)completionHandler;

-(void)search:(NSString *_Nonnull)searchTerm pageNumber:(int)pageNumber withCompletion:(kDictionaryCompletion _Nonnull)completion;

@end