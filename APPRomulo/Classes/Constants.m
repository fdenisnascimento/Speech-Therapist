//---------------------------------------------------------------------------
//
//  Constants.m
//
//
//  Created by Rafael Toshiro on 7/22/09.
//  Copyright 2009 Gol Mobile. All rights reserved.
//
//---------------------------------------------------------------------------

#import "Constants.h"


static NSString *BUNDLE_FOLDER = nil;
static NSString *DOCUMENTS_FOLDER = nil;
static NSString *LIBRARY_CACHE_FOLDER = nil;


@implementation Constants

+ (Boolean)isIpad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
    return NO;
}

+ (NSString *)documentsFolder
{
    if (!DOCUMENTS_FOLDER)
        DOCUMENTS_FOLDER = [self libraryCacheFolder];// [[NSString alloc] initWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
    return DOCUMENTS_FOLDER;
}

+ (NSString *)libraryCacheFolder
{
    if (!LIBRARY_CACHE_FOLDER)
        LIBRARY_CACHE_FOLDER = [[NSString alloc] initWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]];
    return LIBRARY_CACHE_FOLDER;
}

+ (NSString *)bundleFolder
{
    if (!BUNDLE_FOLDER)
        BUNDLE_FOLDER = [[NSString alloc] initWithString:[[NSBundle mainBundle] resourcePath]];
    return BUNDLE_FOLDER;
}

+ (void)setAlertaViewWithTitle:(NSString*)title andMessage:(NSString*)message andButtonText:(NSString*)buttonText{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:buttonText otherButtonTitles:nil, nil];
    [alert show];
  
    
}



+ (Boolean)validateCpfWithString:(NSString*)cpf{
    
    return true;
    
}
//---------------------------------------------------------------------------

+ (BOOL)isNumeric:(NSString*)inputString
{
    BOOL isValid = NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}



+(BOOL) IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


+ (NSArray *)arrangeCopyWithString:(NSString *)searchString andAllItems:(NSArray*)allItems
{
    
    NSMutableArray *filteredObjects = [NSMutableArray arrayWithCapacity:[allItems count]];
    
    NSEnumerator *enumerator = [allItems objectEnumerator];
    
    id item;
    while ((item = [enumerator nextObject])) {
        
        NSString *filename;
        filename = [item valueForUndefinedKey:@"titulo"];
        
        //   NSLog(@"filename:%@ - texto:%@",[filename uppercaseString],[ searchString uppercaseString]);
        
        NSRange range;
        range = [filename rangeOfString:searchString  options: NSDiacriticInsensitiveSearch | NSCaseInsensitiveSearch];
        //    NSLog(@"range:%@",NSStringFromRange(range));
        
        if (range.location != NSNotFound) {
            [filteredObjects addObject: item];
            
        }
    }
    
    return  filteredObjects;
    
}

@end

