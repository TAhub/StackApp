//
//  OAuthViewController.m
//  StackApp
//
//  Created by Theodore Abshire on 12/7/15.
//  Copyright © 2015 TheodoreAbshire. All rights reserved.
//

#import "OAuthViewController.h"

#define OAUTHV_CLIENTID @"6109"
#define OAUTHV_BASEURL @"https://stackexchange.com/oauth/dialog?"
#define OAUTHV_REDIRECTURI @"https://stackexchange.com/oauth/login_success"

@import WebKit;

@interface OAuthViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation OAuthViewController

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"] != nil)
	{
		//you already are logged in
		
		NSLog(@"Have a token!");
		
		[self performSegueWithIdentifier:@"giveMeABurger" sender:self];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"token"] == nil)
	{
		//add the web view
		self.webView = [WKWebView new];
		self.webView.frame = self.view.frame;
		self.webView.navigationDelegate = self;
		[self.view addSubview:self.webView];
		
		//make the url to travel to
		NSString *urlString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@", OAUTHV_BASEURL, OAUTHV_CLIENTID, OAUTHV_REDIRECTURI];
		NSURL *url = [NSURL URLWithString:urlString];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		
		//load the url
		[self.webView loadRequest:request];
	}
}

#pragma mark - web view delegate
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
	NSURLRequest *request = navigationAction.request;
	NSURL *url = request.URL;
	
	if ([url.description containsString:@"access_token"])
	{
		NSArray *components1 = [url.description componentsSeparatedByString:@"="];
		NSString *tPart1 = [components1 objectAtIndex:(components1.count - 2)];
		NSArray *components2 = [tPart1 componentsSeparatedByString:@"&"];
		NSString *token = components2.firstObject;
		[[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
		
		NSLog(@"Logged token!");
		
		[self performSegueWithIdentifier:@"giveMeABurger" sender:self];
	}
	
	decisionHandler(WKNavigationActionPolicyAllow);
}

@end
