//
//  EGOImageView.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGOImageView.h"
#import "EGOImageLoader.h"

@implementation EGOImageView
@synthesize imageURL, placeholderImage, activityIndicator, delegate;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate {
	if((self = [super initWithImage:anImage])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
	}
	return self;
}

- (void)setImageURL:(NSURL *)aURL {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.hidesWhenStopped = YES;
        self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
		[self addSubview:self.activityIndicator];
        CGSize activityIndicatorSize = self.activityIndicator.frame.size;
       
		self.activityIndicator.frame = CGRectMake(self.frame.size.width/2 - activityIndicatorSize.width/2, self.frame.size.width/2 - activityIndicatorSize.width/2, activityIndicatorSize.width, activityIndicatorSize.height);
	if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		imageURL = nil;
	}
	
	if(!aURL) {
		self.image = self.placeholderImage;
		imageURL = nil;
		return;
	} else {
		imageURL = aURL ;
	}
	
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	UIImage* anImage = [[EGOImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
	
	if(anImage) {
		self.image = anImage;
        [self.activityIndicator stopAnimating];
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
		} 
    } else {
        [self.activityIndicator startAnimating];
		self.image = self.placeholderImage;
	}
}

#pragma mark - Image loading
- (void)cancelImageLoad {
    [self.activityIndicator stopAnimating];
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
    [self.activityIndicator stopAnimating];
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
	UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
	self.image = anImage;
	[self setNeedsDisplay];
    
	if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
		[self.delegate imageViewLoadedImage:self];
	}	
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
    [self.activityIndicator stopAnimating];
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
    
	if([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
		[self.delegate imageViewFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}

#pragma mark -
- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	self.imageURL = nil;
	self.placeholderImage = nil;
}

@end