//  JSONParser.m
//  TestWebService
//  Created by apple on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "JSONParser.h"

@implementation JSONParser
@synthesize MainHandler,targetSelector,rq;
-(id)initWithRequestForThread:(NSMutableURLRequest*)urlReq sel:(SEL)seletor andHandler:(NSObject*)handler {
	if (self=[super init]) {
		self.MainHandler = handler;
		self.targetSelector = seletor;
		self.rq=urlReq;
		
		[self performSelectorOnMainThread:@selector(startParse) withObject:nil waitUntilDone:NO];
	}
	return self;
}

-(void)startParse {
	con = [[NSURLConnection alloc] initWithRequest:rq delegate:self];
	if (con) {
		myWebData = [NSMutableData data] ;
	}
    else {
		[self performSelectorOnMainThread:@selector(targetSelector:) withObject:nil waitUntilDone:NO];
	}
}

//-------------------------------connection---------------------
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[myWebData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[myWebData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"connection did fail");
	NSLog(@"%@",error);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *jsonString = [[NSString alloc] initWithData:myWebData encoding:NSUTF8StringEncoding];
	NSDictionary *results = [jsonString JSONValue];
	[MainHandler performSelector:targetSelector withObject:results];
}

@end