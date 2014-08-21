//
//  XWAppDelegate.h
//  XWing Squadron Builder
//
//  Created by Fiorio Christophe on 21/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (BOOL)saveManagedObjectContext:(NSError **)error;

@end
