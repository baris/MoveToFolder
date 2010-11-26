//
//  TableViewManager+Extras.m
//  MoveToFolder
//
//  Created by Baris Metin on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableViewManager+Extras.h"
#import "MoveToFolder.h"


@implementation TableViewManager (Extras)

+ (void)load
{
    // Replace the original awakeFromNib method to inject our code
    [MoveToFolder replaceMethod:@selector(awakeFromNib)
                        inClass:[self class]
                     withMethod:@selector(my_awakeFromNib)
                      fromClass:[self class]];
    
    NSLog(@"Loaded TableViewManager");
}


- (void)my_awakeFromNib
{
    // Create a MenuItem under global Message menu and add a keyEquivalent to register our action.
    NSMenuItem *message = [MoveToFolder getMainMenuItem:@"Message"];
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Show Move Menu"
                                                  action:@selector(showMoveMenu) 
                                           keyEquivalent:@"\r"];
    [item autorelease];
    [item setTarget:self];    
    [[message submenu] addItem:item];
    
    // call the original method
    [self performSelector:NSSelectorFromString(@"awakeFromNib_original")];
    NSLog(@"TableViewManager awakeFromNib");
}

- (void)showMoveMenu
{
    // Create a dummy event to set the location to the mouse location.
    NSEvent* event = [NSEvent otherEventWithType:NSApplicationDefined
                                        location:[self mouseLocationInWindow]
                                   modifierFlags:0 
                                       timestamp:0
                                    windowNumber:[[_tableView window] windowNumber]
                                         context:[[_tableView window] graphicsContext]
                                         subtype:100
                                           data1:0
                                           data2:0];
    
    // Get the "Move To" submenu from the tableview's context menu and display it.
    NSMenuItem *move = [MoveToFolder getMenuItem:@"Move To" from:[_tableView menu]];
    [NSMenu popUpContextMenu:[move submenu] withEvent:event forView:(NSView*)_tableView];
}



@end
