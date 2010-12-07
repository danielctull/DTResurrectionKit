//
//  DTResurrectionKitAppDelegate.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 03.11.2009.
//  Copyright Daniel Tull 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTResurrectionKit.h"

@interface DTResurrectionKitAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	DTResurrectionController *resurrectionController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

