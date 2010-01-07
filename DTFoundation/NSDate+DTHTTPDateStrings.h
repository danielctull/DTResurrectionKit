//
//  NSDate+DTHTTPDateStrings.h
//  DTFoundation
//
//  Created by Daniel Tull on 18.12.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//
//	http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1
//

#import <Foundation/Foundation.h>
@interface NSDate (DTHTTPDateStrings)

+ (NSDate *)dateFromHTTPFormattedDateString:(NSString *)string;
+ (NSDate *)dateFromRFC1123String:(NSString *)string;
+ (NSDate *)dateFromRFC1036String:(NSString *)string;
+ (NSDate *)dateFromANSICString:(NSString *)string;


- (NSString *)HTTPFormattedDateString;
- (NSString *)RFC1123String;
- (NSString *)RFC1036String;
- (NSString *)ANSICString;

@end