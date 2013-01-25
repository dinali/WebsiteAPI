//
//  Parser.h
//  Tabs
//
//  Created by Dina Li on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Record.h"
//#import "Title.h"

@interface Parser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *recordsArray;

-(id) loadXMLByURL:(NSString *)urlString;

@end

