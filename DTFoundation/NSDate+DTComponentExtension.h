//
//  NSDate+DTExtras.h
//  DTFoundation
//
//  Created by Daniel Tull on 28.07.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>

/** An extension to NSDate to have easier access to the individual components
 based on the gregorian calendar.
 */
@interface NSDate (DTComponentExtension)

/** @name Getting Gregorian date components
 @{
 */

- (NSDateComponents *)gregorianCalendarComponents;

/**
 @}
 */

/** @name Getting individual components
 @{
 */

/** @brief The second component of the receiver.
 
 @return The second component of the receiver as an integer.
 */
- (NSInteger)second;

/** @brief The minute component of the receiver.
 
 @return The minute component of the receiver as an integer.
 */
- (NSInteger)minute;

/** @brief The hour component of the receiver.
 
 @return The hour component of the receiver as an integer.
 */
- (NSInteger)hour;

/** @brief The day component of the receiver.
 
 @return The day component of the receiver as an integer.
 */
- (NSInteger)day;

/** @brief The weekday component of the receiver.
 
 @return The weekday component of the receiver as an integer.
 */
- (NSInteger)weekday;

/** @brief The weekdayOrdinal component of the receiver.
 
 @return The weekdayOrdinal component of the receiver as an integer.
 */
- (NSInteger)weekdayOrdinal;

/** @brief The week component of the receiver.
 
 @return The week component of the receiver as an integer.
 */
- (NSInteger)week;

/** @brief The month component of the receiver.
 
 @return The month component of the receiver as an integer.
 */
- (NSInteger)month;

/** @brief The year component of the receiver.
 
 @return The year component of the receiver as an integer.
 */
- (NSInteger)year;

/** @brief The era component of the receiver.
 
 @return The era component of the receiver as an integer.
 */
- (NSInteger)era;

/**
 @}
 */

/** @name Creating a date
 @{
 */

/** @brief Creates a data with a month and year.
 
 @param month The month of the date.
 @param year The year of the date.
 
 @return The newly created date.
 */
+ (NSDate *)dateWithMonth:(NSInteger)month year:(NSInteger)year;

/** @brief Creates a data with a year.
 
 @param year The year of the date.
 
 @return The newly created date.
 */
+ (NSDate *)dateWithYear:(NSInteger)year;

/** @brief Creates a data with a year and month.
 
 @param year The year of the date.
 @param month The month of the date.
 
 @return The newly created date.
 */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month;

/** @brief Creates a data with a year, month and day.
 
 @param year The year of the date.
 @param month The month of the date.
 @param day The day of the date.
 
 @return The newly created date.
 */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/** @brief Creates a data with a year, month, day and hour.
 
 @param year The year of the date.
 @param month The month of the date.
 @param day The day of the date.
 @param hour The hour of the date.
 
 @return The newly created date.
 */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour;

/** @brief Creates a data with a year, month, day, hour and minute.
 
 @param year The year of the date.
 @param month The month of the date.
 @param day The day of the date.
 @param hour The hour of the date.
 @param minute The minute of the date.
 
 @return The newly created date.
 */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;

/** @brief Creates a data with a year, month, day, hour, minute and second.
 
 @param year The year of the date.
 @param month The month of the date.
 @param day The day of the date.
 @param hour The hour of the date.
 @param minute The minute of the date.
 @param second The second of the date.
 
 @return The newly created date.
 */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/**
 @}
 */

@end
