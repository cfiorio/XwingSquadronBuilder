//
//  Faction.h
//  XWing Squadron Builder
//
//  Created by Fiorio Christophe on 21/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ShipType;

@interface Faction : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *shipTypes;
@property (nonatomic, retain) NSSet *squadrons;
@end

@interface Faction (CoreDataGeneratedAccessors)

- (void)addShipTypesObject:(ShipType *)value;
- (void)removeShipTypesObject:(ShipType *)value;
- (void)addShipTypes:(NSSet *)values;
- (void)removeShipTypes:(NSSet *)values;

- (void)addSquadronsObject:(NSManagedObject *)value;
- (void)removeSquadronsObject:(NSManagedObject *)value;
- (void)addSquadrons:(NSSet *)values;
- (void)removeSquadrons:(NSSet *)values;

@end
