//
//  Parser.m
//  ParseERSfeed
//
//  Created by Dina Li on 9/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//
//  Parser.m
//  Parse2
//
//  Created by Dina Li on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
// TODO: not reading the service
//

#import "Parser.h"
#import "Record.h"
//#import "Title.h"

@implementation Parser

@synthesize recordsArray = _recordsArray;

NSMutableString	*currentNodeContent;
NSXMLParser		*parser;
Record			*currentRecord;
//Title              *titleText;
bool            isStatus;
NSMutableString *workingPropertyString;

// element names
static NSString *kEntryStr = @"JSON"; // this is the top element
static NSString *kTitleStr = @"Title";
//static NSString *kDescriptionStr = @"description";
static NSString *kLinkStr = @"Url";

-(id) loadXMLByURL:(NSString *)urlString
{
	_recordsArray	= [[NSMutableArray alloc] init];
	NSURL *url		= [NSURL URLWithString:urlString];
	NSData	*data   = [[NSData alloc] initWithContentsOfURL:url];
	parser			= [[NSXMLParser alloc] initWithData:data];
	parser.delegate = self;
    
    @try {
        NSLog(@"url in loadXMLByURL %@", url);
        [parser parse];
    }
    @catch (NSException *exception) {
        NSLog(@"exception %@", exception);
    }
    @finally {
    }
	return self;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"foundCharacters: currentNodeContent %@", currentNodeContent);
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"didStartElement head");

    // skip the first few elements
    if ([elementName isEqualToString:kEntryStr]) // JSON
    {
        currentRecord = [[Record alloc] init];
        isStatus = YES;
        NSLog(@"item");
    }
    if ([elementName isEqualToString:kTitleStr])
    {
        //currentRecord.titleString = currentNodeContent;
        NSLog(@"start Title %@", currentNodeContent);
    }
    if ([elementName isEqualToString:kLinkStr])
    {
        // currentRecord.linkString = currentNodeContent;
        NSLog(@"start link %@", currentNodeContent);
    }
//    if ([elementName isEqualToString:kDescriptionStr])
//    {        
//        //currentRecord.descriptionString = currentNodeContent;
//        NSLog(@"start description %@", currentNodeContent);
//    }
//    if([elementName isEqualToString:@"p"]) // nested in description
//    {
//        // currentRecord.descriptionString = currentNodeContent;
//        // NSLog(@"start p = %@", currentNodeContent);
//    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"didEndElement head");
    
    if (isStatus)
    {
        // [currentNodeContent setString:@""];  // clear the string for next time
        
        if ([elementName isEqualToString:kTitleStr])
        {
            currentRecord.titleString = currentNodeContent;
            NSLog(@"end Title %@", currentNodeContent);
        }
        else if ([elementName isEqualToString:kLinkStr])
        {
            currentRecord.linkString = currentNodeContent;
            NSLog(@"endlink %@", currentNodeContent);
        }
//        else if ([elementName isEqualToString:kDescriptionStr])
//        {   
//            // NSLog(@"found end description");
//            currentRecord.descriptionString = currentNodeContent;
//            NSLog(@"end p = %@", currentNodeContent);
//            
//            if([elementName isEqualToString:@"p"])
//            {
//                currentRecord.descriptionString = currentNodeContent;
//                NSLog(@"end p = %@", currentNodeContent);
//            }
//        }
//        else if([elementName isEqualToString:@"p"])
//        {
//            currentRecord.descriptionString = currentNodeContent;
//            NSLog(@"end p = %@", currentNodeContent);
//        }
        // item is the top level element
        else if ([elementName isEqualToString:kEntryStr])
        {
            [self.recordsArray addObject:currentRecord];  
            currentRecord = nil; 
            NSLog(@"added the object");
        }
    } // end if status
}

@end

