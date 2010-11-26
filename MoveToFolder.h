//
//  MoveTo.h
//  MoveToFolder
//
//  Created by Baris Metin on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MoveToFolder : NSObject {

}


// Helper functions
+ (void)replaceMethod:(SEL)orig inClass:(Class)incls withMethod:(SEL)alt fromClass:(Class)fromcls;

+ (NSMenuItem *)getMenuItem:(NSString*)name from:(NSMenu*)menu;
+ (NSMenuItem *)getMainMenuItem:(NSString*)name;


@end
