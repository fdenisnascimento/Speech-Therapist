//
//  DBHandler.h
//  BancoDeDados
//
//  Created by Denis Nascimento on 06/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Constants.h"

@interface DBHandler : NSObject {

}
+(DBHandler*)shared;
-(sqlite3_stmt*)runSQL:(NSString*)sql;
-(void)runScript:(NSString*)filename;
+(NSString*)cStringToOBJC:(const char *)cString;

@end
