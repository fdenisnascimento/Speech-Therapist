//
//  Constants.h
//  UOLPlacar
//
//  Created by Rafael Toshiro on 12/11/09.
//  Copyright 2009 Gol Mobile. All rights reserved.
//

#ifndef GOL_CONSTANTS
#define GOL_CONSTANTS

#import <Foundation/Foundation.h>



#define DBFileName @"appromulo.sqlite"
#define DATABASE_NAME_FILE [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:DBFileName]
#define DATABASE_NAME_FILE_ORIG [[Constants bundleFolder]  stringByAppendingPathComponent:DBFileName]

#define OJORNALEIRODBFile [[Constants libraryCacheFolder] stringByAppendingPathComponent:DBFileName]


#define CACHE_TEMP_DIR [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/tempdir"]



#define STRING_APP_NAME @"O Jornaleiro"
#define DATABASE_NAME @"nuvem.sqlite" 

#define PROGRESS_NOTIFICATION @"progressNotification"


#define TAG_PROGRESS  63527 

#define GOL_INTERVAL                          120
#define GOL_INTERVAL_UPDATE                    60
#define MAX_COUNTER_BOOKS                       5

// HEIGHTS

#define HEIGHT_OF_STATUS_BAR 20
#define HEIGHT_OF_TOOLBAR 44
#define HEIGHT_OF_TABLE_CELL 44
#define HEIGHT_OF_TAB_BAR 49
#define HEIGHT_OF_SEARCH_BAR 44
#define HEIGHT_OF_NAVIGATION_BAR 44
#define HEIGHT_OF_TEXTFIELD 31
#define HEIGHT_OF_PICKER 216
#define HEIGHT_OF_KEYBOARD 216
#define HEIGHT_OF_SEGMENTED_CONTROL 43
#define HEIGHT_OF_SEGMENTED_CONTROL_BAR 29
#define HEIGHT_OF_SEGMENTED_CONTROL_BEZELED 40
#define HEIGHT_OF_SWITCH 27
#define HEIGHT_OF_SLIDER 22
#define HEIGHT_OF_PROGRESS_BAR 9
#define HEIGHT_OF_PAGE_CONTROL 36
#define HEIGHT_OF_BUTTON 37

// TIME CONSTANTS

#define SECONDS_IN_MINUTE 60
#define SECONDS_IN_HOUR 3600
#define SECONDS_IN_DAY 86400
#define SECONDS_IN_WEEK 604800
#define MINUTES_IN_HOUR 60
#define HOURS_IN_DAY 24
#define DAYS_IN_WEEK 7


////MACROS
#define width(a) a.frame.size.width
#define height(a) a.frame.size.height
#define top(a) a.frame.origin.y
#define left(a) a.frame.origin.x
#define FrameReposition(a,x,y) a.frame = CGRectMake(x, y, width(a), height(a))
#define FrameResize(a,w,h) a.frame = CGRectMake(left(a), top(a), w, h)


    //RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLOR_FUNDO_CELL [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.0]


// For text, messages, etc
#define DEFAULT_FONTSIZE    15
#define DEFAULT_FONT(s)     [UIFont fontWithName:@"ArialMT" size:s]
#define DEFAULT_BOLDFONT(s) [UIFont fontWithName:@"Arial-BoldMT" size:s]
#define FONT_COLOR_NUVEM    [UIColor colorWithRed:0.000 green:0.231 blue:0.345 alpha:1.0]

// For table cells
#define CELL_FONTSIZE    16
#define CELL_FONT(s)     [UIFont fontWithName:@"Helvetica-Oblique" size:s]
#define CELL_BOLDFONT(s) [UIFont fontWithName:@"Helvetica-BoldOblique" size:s]


#if DEBUG==0
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK	CMLog(@"%s", __PRETTY_FUNCTION__);
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) 	NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);

#else
#define CMLog(format, ...)
#define MARK
#define START_TIMER
#define END_TIMER(msg)
#endif

typedef enum 
{
  kLoadingTypeNormal,
  kLoadingTypeNew
}LoadingType;

typedef enum 
{
  kPlistType = 0,
  kJSONType
}DataType;



@interface Constants : NSObject
{
}

+ (Boolean)isIpad;

+ (NSString *)bundleFolder;
+ (NSString *)documentsFolder;
+ (NSString *)libraryCacheFolder;

+ (void)setAlertaViewWithTitle:(NSString*)title andMessage:(NSString*)message andButtonText:(NSString*)buttonText;
+ (BOOL)isNumeric:(NSString*)inputString;
+ (BOOL) IsValidEmail:(NSString *)checkString;

+ (NSArray *)arrangeCopyWithString:(NSString *)searchString andAllItems:(NSArray*)allItems;

@end

#endif