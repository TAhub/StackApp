//
//  StackWebService.m
//  StackApp
//
//  Created by Theodore Abshire on 12/8/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "StackWebService.h"
#import "AFNetworking.h"
#import "Errors.h"

@interface StackWebService()

@property dispatch_group_t imageGroup;

@end

@implementation StackWebService

+(nonnull id)sharedService
{
	static StackWebService *service = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		service = [[self alloc] init];
		service.imageGroup = dispatch_group_create();
	});
	return service;
}

-(void)registerImageFinish:(kImageFinishCompletion)completion
{
	dispatch_group_notify(self.imageGroup, dispatch_get_main_queue(),
	^{
		completion();
	});
}

-(void)setupReachability:(AFHTTPRequestOperationManager*)manager
{
	NSOperationQueue *q = manager.operationQueue;
	[manager.reachabilityManager setReachabilityStatusChangeBlock:
	^(AFNetworkReachabilityStatus status){
		switch(status)
		{
		case AFNetworkReachabilityStatusReachableViaWiFi:
		case AFNetworkReachabilityStatusReachableViaWWAN:
			//you can reach it!
			[q setSuspended:NO];
			break;
		case AFNetworkReachabilityStatusNotReachable:
		default:
			//you can't reach it
			[q setSuspended:YES];
			break;
		}
	}];
}

-(void)getRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters withCompletion:(kDataCompletion)completionHandler
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	[self setupReachability:manager];
	
	[manager GET:url parameters:parameters success:
	^(AFHTTPRequestOperation* _Nonnull operation, id _Nonnull responseObject) {
		NSData *data = (NSData *)responseObject;
		completionHandler(data, nil);
	} failure:^(AFHTTPRequestOperation* _Nullable operation, NSError* _Nonnull error) {
		completionHandler(nil, error);
	}];
}

-(void)postRequestWithURL:(NSString *)url parameters:(NSDictionary *)parameters withCompletion:(kDataCompletion)completionHandler
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	[self setupReachability:manager];
	
	[manager POST:url parameters:parameters success:
	^(AFHTTPRequestOperation* _Nonnull operation, id _Nonnull responseObject) {
		NSData *data = (NSData *)responseObject;
		completionHandler(data, nil);
	} failure:^(AFHTTPRequestOperation* _Nullable operation, NSError* _Nonnull error) {
		completionHandler(nil, error);
	}];
}

-(void)fetchImageInBackgroundFromURL:(NSURL *)url completionHandler:(kImageCompletion)completionHandler
{
	__weak typeof(self) weakSelf = self;
	
	dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
	dispatch_async(q, ^{
		dispatch_group_enter(weakSelf.imageGroup);
		
		NSError *error;
		NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
		
		UIImage *fetched = [[UIImage alloc] initWithData:data];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (error == nil && data != nil)
			{
				completionHandler(fetched, nil);
				return;
			}
			if (error == nil && data == nil)
			{
				completionHandler(nil, StackAppFailedToLoadImage);
				return;
			}
			completionHandler(nil, error);
			return;
		});
		
		dispatch_group_leave(weakSelf.imageGroup);
	});
}

-(void)search:(NSString *)searchTerm pageNumber:(int)pageNumber withCompletion:(kDictionaryCompletion)completion
{
	NSString *searchString = @"https://api.stackexchange.com/2.2/search";
	NSString *sortString = @"votes";
	NSString *orderString = @"asc";
	NSString *pageNumberString = (pageNumber > 0 ? [NSString stringWithFormat:@"%d", pageNumber] : @"1");
	
	NSMutableDictionary *parameters = [NSMutableDictionary new];
	[parameters setObject:pageNumberString forKey:@"page"];
	[parameters setObject:sortString forKey:@"sort"];
	[parameters setObject:orderString forKey:@"order"];
	[parameters setObject:searchTerm forKey:@"intitle"];
	[parameters setObject:@"stackoverflow" forKey:@"site"];
	
	[self getRequestWithURL:searchString parameters:parameters withCompletion:
	^(NSData* _Nullable data, NSError* _Nullable error){
		if (error == nil)
		{
			NSDictionary *dictionary = (NSDictionary *)data;
			completion(dictionary, nil);
		}
		else
			completion(nil, error);
	}];
}

@end