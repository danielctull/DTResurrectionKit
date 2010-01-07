//
//  NSString+DTLeadingZeros.h
//  DTFoundation
//
//  Created by Daniel Tull on 01.08.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DTPrefixString)
/** @brief prefixes the receiver with the given string to make it a certain length.
 
 
 
 @param insertString The string to insert.
 @param desiredStringLength The deisred length of the resulting string. 
 @return The prefixed string of desired length.
 */
- (NSString *)stringByPrefixingWithString:(NSString *)insertString resultingInLength:(NSInteger)desiredStringLength;
@end