//
//  DTResurrection.h
//  DTResurrectionKit
//
//  Created by Daniel Tull on 09.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

@protocol DTResurrection
- (id)initWithResurrector:(DTResurrector *)resurrector;
- (void)encodeToResurrector:(DTResurrector *)resurrector;
@end