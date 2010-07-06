//
//  DTContentController.m
//  DTKit
//
//  Created by Daniel Tull on 23.10.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTContentController.h"
//#import "DTSpringBack.h"

@interface DTContentController ()


@end


@implementation DTContentController

@synthesize position, barView, contentView, viewController;

- (id)initWithViewController:(UIViewController *)aViewController {
	
	if (!(self = [super init])) return nil;
	
	self.wantsFullScreenLayout = YES;
	viewController = [aViewController retain];
	
	return self;
}

- (void)dealloc {
	[viewController release];
	[barView release];
	[contentView release];
    [super dealloc];
}
/*
- (id)initWithArchiver:(DTResurrector *)archiver {
	return [self initWithViewController:[resurrector objectForKey:@"viewController"]];
}

- (void)encodeToArchiver:(DTResurrector *)archiver {
	[resurrector setObject:self.viewController forKey:@"viewController"];
}*/

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view addSubview:self.contentView];
		
	self.barView.frame = [self barFrame];
	
	if (self.position == DTBarPositionTop)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin);
	else if (self.position == DTBarPositionBottom)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
	else if (self.position == DTBarPositionRight)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin);
	else if (self.position == DTBarPositionLeft)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin);
	
	[self.view addSubview:self.barView];
	self.contentView.frame = [self contentFrame];
	self.contentView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	self.viewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.viewController.view.frame = self.contentView.bounds;
	self.viewController.wantsFullScreenLayout = YES;
	
	[self.contentView addSubview:self.viewController.view];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.contentView = nil;
	self.barView = nil;
}

- (UITabBarItem *)tabBarItem {
	return [self.viewController tabBarItem];
}

- (UINavigationItem *)navigationItem {
	return [self.viewController navigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	[self.viewController didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UIViewController view event methods


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.viewController viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.viewController viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.viewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.viewController viewDidDisappear:animated];
}

#pragma mark -
#pragma mark UIViewController autorotation methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return [self.viewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.viewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self.viewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.viewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:toInterfaceOrientation];
	[self.viewController didRotateFromInterfaceOrientation:toInterfaceOrientation];
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
	[self.viewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}




#pragma mark -
#pragma mark Methods for subclasses to use

- (void)loadContentView {}



#pragma mark -
#pragma mark Public methods

- (void)setBarHidden:(BOOL)hidden animated:(BOOL)animated {
	if (barHidden == hidden) return;
	
	barHidden = hidden;
	
	if (self.position == DTBarPositionNone) return;
	
	if (animated) [UIView beginAnimations:@"hidingOrShowingTabBar" context:nil]; 
	
	if (hidden) {
		self.contentView.frame = self.view.bounds;
		
		if (self.position == DTBarPositionBottom)
			self.barView.frame = CGRectMake(self.barView.frame.origin.x, self.barView.frame.origin.y + self.barView.frame.size.height, self.barView.frame.size.width, self.barView.frame.size.height);
		
		else if (self.position == DTBarPositionTop)
			self.barView.frame = CGRectMake(self.barView.frame.origin.x, self.barView.frame.origin.y - self.barView.frame.size.height, self.barView.frame.size.width, self.barView.frame.size.height);
		
		else if (self.position == DTBarPositionRight)
			self.barView.frame = CGRectMake(self.barView.frame.origin.x + self.barView.frame.size.width, self.barView.frame.origin.y, self.barView.frame.size.width, self.barView.frame.size.height);
		
		else if (self.position == DTBarPositionLeft)
			self.barView.frame = CGRectMake(self.barView.frame.origin.x - self.barView.frame.size.width, self.barView.frame.origin.y, self.barView.frame.size.width, self.barView.frame.size.height);
		
	} else {
		self.barView.frame = [self barFrame];
		self.contentView.frame = [self contentFrame];
	}
	if (animated) [UIView commitAnimations];
}

#pragma mark -
#pragma mark Accessor methods

- (UIView *)contentView {
	if (!contentView) contentView = [[UIView alloc] initWithFrame:[self contentFrame]];
	return contentView;
}

#pragma mark -
#pragma mark Framing methods

- (CGRect)barFrame {
	if (self.position == DTBarPositionBottom)
		return CGRectMake(0.0,
						  self.view.frame.size.height - self.barView.frame.size.height,
						  self.view.frame.size.width,
						  self.barView.frame.size.height);
	
	else if (self.position == DTBarPositionTop)
		return CGRectMake(0.0, 
						  0.0, 
						  self.view.frame.size.width, 
						  self.barView.frame.size.height);
	
	else if (self.position == DTBarPositionRight)
		return CGRectMake(self.view.frame.size.width - self.barView.frame.size.width,
						  0.0,
						  self.barView.frame.size.width,
						  self.view.frame.size.height);
	
	else if (self.position == DTBarPositionLeft)
		return CGRectMake(0.0, 
						  0.0,
						  self.barView.frame.size.width, 
						  self.view.frame.size.height);
	
	return CGRectZero;
}

- (CGRect)contentFrame {
	
	if (!self.barView) return self.view.bounds;
	
	if (self.position == DTBarPositionBottom)
		return CGRectMake(0.0, 
						  0.0, 
						  self.view.frame.size.width, 
						  self.view.frame.size.height - self.barView.frame.size.height);
	
	else if (self.position == DTBarPositionTop)
		return CGRectMake(0.0,
						  self.barView.frame.size.height, 
						  self.view.frame.size.width, 
						  self.view.frame.size.height - self.barView.frame.size.height);
	
	else if (self.position == DTBarPositionRight)
		return CGRectMake(0.0, 
						  0.0, 
						  self.view.frame.size.width - self.barView.frame.size.width, 
						  self.view.frame.size.height);
	
	else if (self.position == DTBarPositionLeft)
		return CGRectMake(self.barView.frame.size.width, 
						  0.0, 
						  self.view.frame.size.width - self.barView.frame.size.width, 
						  self.view.frame.size.height);
	
	return self.view.frame;
}

@end
