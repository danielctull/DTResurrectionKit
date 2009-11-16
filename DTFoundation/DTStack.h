//
//  DTStack.h
//  DTKit
//
//  Created by Daniel Tull on 05.04.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DTStack : NSObject {
	NSMutableArray *queue;
}

- (NSUInteger)count;
- (void)push:(id)object;
- (id)pop;

- (NSArray *)allObjects;
- (NSArray *)popToObject:(id)object;
- (NSArray *)popToRootObject;
- (id)topObject;

@end
