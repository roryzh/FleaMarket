//
//  CoreDataUtils.m
//  RoseTask
//
//  Created by RoryZhuang on 7/20/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import "CoreDataUtils.h"
#import "AppDelegate.h"

static NSManagedObjectContext* __managedObjectContext;

@implementation CoreDataUtils

+ (NSManagedObjectContext*) managedObjectContext {
    if(__managedObjectContext == nil) {
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        __managedObjectContext = appDelegate.managedObjectContext;
        
    }
    return __managedObjectContext;
}
+ (void) saveContext {
    NSManagedObjectContext* context = [CoreDataUtils managedObjectContext];
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}

@end
