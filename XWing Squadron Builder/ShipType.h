//
//  ShipType.h
//  XWing Squadron Builder
//
//  Created by Fiorio Christophe on 21/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Faction, Pilot, ShipSize;

@interface ShipType : NSManagedObject

@property (nonatomic) int16_t index;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Faction *faction;
@property (nonatomic, retain) NSSet *pilots;
@property (nonatomic, retain) ShipSize *size;
@property (nonatomic, retain) NSSet *spaceships;
@property (nonatomic, retain) NSSet *upgradestypes;
@end

@interface ShipType (CoreDataGeneratedAccessors)

- (void)addPilotsObject:(Pilot *)value;
- (void)removePilotsObject:(Pilot *)value;
- (void)addPilots:(NSSet *)values;
- (void)removePilots:(NSSet *)values;

- (void)addSpaceshipsObject:(NSManagedObject *)value;
- (void)removeSpaceshipsObject:(NSManagedObject *)value;
- (void)addSpaceships:(NSSet *)values;
- (void)removeSpaceships:(NSSet *)values;

- (void)addUpgradestypesObject:(NSManagedObject *)value;
- (void)removeUpgradestypesObject:(NSManagedObject *)value;
- (void)addUpgradestypes:(NSSet *)values;
- (void)removeUpgradestypes:(NSSet *)values;

@end
