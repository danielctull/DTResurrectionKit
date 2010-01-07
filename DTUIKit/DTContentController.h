//
//  DTContentController.h
//  DTKit
//
//  Created by Daniel Tull on 23.10.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	DTBarPositionNone = 0,
	DTBarPositionLeft,
	DTBarPositionRight,
	DTBarPositionTop,
	DTBarPositionBottom
} DTBarPosition;

@interface DTContentController : UIViewController {
	BOOL barHidden;
	DTBarPosition position;
	UIView *barView, *contentView;
	UIViewController *viewController;
}

@property (nonatomic, assign) DTBarPosition position;
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, retain) IBOutlet UIView *barView, *contentView;

// For subclasses really:
- (CGRect)barFrame;
- (CGRect)contentFrame;
- (void)loadContentView;

// Publically Use:
- (id)initWithViewController:(UIViewController *)aViewController;
- (void)setBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
