//
//  Faction+DataModel.h
//  XWing builder
//
//  Created by Fiorio Christophe on 18/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "Faction.h"

@interface Faction (DataModel)

// get a managedObject for a faction with name aname
// if an entity with this name already exists in persistent storage, return a Faction initialized with this entity
// else alloc a new object and set its name to aname
+ (Faction*) getFactionWithName:(NSString*)aname withEntityDescription:(NSEntityDescription*)entity inManagedObjectContext:(NSManagedObjectContext*)context;

// create a new managedObject for a Faction with name aname and initialize it
// if an entity with this name already exists in persistent storage, return nil as an error since
// we are trying to create a new Faction
// else alloc a new object and set its name to aname
// note: context is not saved
// note: this method use getFactionWithName method to initialize NSManagedObject and check data
+ (Faction*) newFaction:(NSEntityDescription*)entity inContext:(NSManagedObjectContext*)context withName:(NSString*)aname;

// initialize all data
// note: should be called only once, since it add data already known... best used in testing phase
+ (void) initializeFactionData:(NSError**)error;

@end
