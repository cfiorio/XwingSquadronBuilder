//
//  ShipType+DataModel.h
//  XWing builder
//
//  Created by Fiorio Christophe on 20/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "ShipType.h"

@interface ShipType (DataModel)

// get a managedObject for a faction with name aname
// if an entity with this name already exists in persistent storage, return a Faction initialized with this entity
// else alloc a new object and set its name to aname
+ (ShipType*) getShipTypeWithName:(NSString*)aname withEntityDescription:(NSEntityDescription*)entity inManagedObjectContext:(NSManagedObjectContext*)context;

// create a new managedObject for a ship type with name aname and initialize it with faction afaction and size asize
// if an entity with this name already exists in persistent storage, return nil as an error since
// we are trying to create a new ShipType initialized with this entity
// else alloc a new object and set its name to aname, its faction to afaction and its size to asize
// note: context is not saved
// note: this method use getShipTypeWithName method to initialize NSManagedObject and check data
+ (ShipType*) newShipType:(NSEntityDescription*)entity inContext:(NSManagedObjectContext*)context
         withName:(NSString*)aname inFaction:(Faction*)afaction ofSize:(ShipSize*)asize indexedBy:(int)anindex;

// initialize all ship types with data
// note: should be called only once, since it add data already known... best used in testing phase
+ (void) initializeShipTypesData:(NSError**)error;

@end
