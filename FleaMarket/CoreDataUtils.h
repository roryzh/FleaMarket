//
//  CoreDataUtils.h
//  RoseTask
//
//  Created by RoryZhuang on 7/20/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataUtils : NSObject

+ (NSManagedObjectContext*) managedObjectContext;
+ (void) saveContext;


@end
