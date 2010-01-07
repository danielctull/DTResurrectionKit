//
//  DTSpringBackAppDelegate.h
//  DTSpringBack
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright Daniel Tull 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTSpringBack.h"

@interface DTSpringBackAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	DTSpringBackController *springBackController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

