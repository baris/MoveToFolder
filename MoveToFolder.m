//
//  MoveTo.m
//  MoveToFolder
//
//  Created by Baris Metin on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "objc/runtime.h" // for class_* and method_* functions
#import "MoveToFolder.h"


@implementation MoveToFolder

+ (void)initialize
{
    // Seems like we don't really need in our case.
    // class_setSuperclass(self, NSClassFromString(@"MVMailBundle"));
    // [super registerBundle];
    
    NSLog(@"Loaded MoveTo mailbundle...");
}

#pragma mark Helper Functions

+ (void)replaceMethod:(SEL)orig inClass:(Class)incls withMethod:(SEL)alt fromClass:(Class)fromcls
{
    // Copy original method named as "ORIGNAME_original" so that the added method can invoke it.
    Method origMethod = class_getInstanceMethod(incls, orig);
    IMP origImpl = class_getMethodImplementation(incls, orig);
    const char * origTypeEncoding = method_getTypeEncoding(origMethod);
    
    NSString *copy_method = [NSString stringWithFormat:@"%@_original", NSStringFromSelector(orig)];
    SEL copy_selector = NSSelectorFromString(copy_method);
    class_addMethod(incls, copy_selector, origImpl, origTypeEncoding);
    
    // Replace the original method with the alternative.
    Method altMethod = class_getInstanceMethod(fromcls, alt);
    IMP altImpl = class_getMethodImplementation(fromcls, alt);
    const char * altTypeEncoding = method_getTypeEncoding(altMethod);
    class_replaceMethod(incls, orig, altImpl, altTypeEncoding);
}


+ (NSMenuItem *)getMenuItem:(NSString*)name from:(NSMenu*)menu
{
    NSArray *items = [menu itemArray];
    for (int i = 0; i < [items count]; i++) {
        NSMenuItem *item = [items objectAtIndex:i];
        if ([[item title] isEqualToString:name]) {
            return item;
        }
    }
    return NULL;    
}

+ (NSMenuItem *)getMainMenuItem:(NSString*)name
{    
    NSMenu *menu = [[NSApplication sharedApplication] mainMenu];
    return [[self class] getMenuItem:name from:menu];
}

@end
