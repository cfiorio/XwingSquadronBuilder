//
//  Pilot.h
//  XWing Squadron Builder
//
//  Created by Fiorio Christophe on 21/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ShipType;

@interface Pilot : NSManagedObject

@property (nonatomic) BOOL accel;
@property (nonatomic) int16_t agility;
@property (nonatomic) BOOL barrel_roll;
@property (nonatomic) BOOL cloak;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic) BOOL evade;
@property (nonatomic) BOOL focus;
@property (nonatomic) int16_t hull;
@property (nonatomic) int16_t ident;
@property (nonatomic) BOOL lock;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t primary_weapon;
@property (nonatomic) int16_t shield;
@property (nonatomic) int16_t skill;
@property (nonatomic) BOOL unique;
@property (nonatomic, retain) ShipType *shipType;
@property (nonatomic, retain) NSSet *spaceships;
@property (nonatomic, retain) NSSet *upgrades_allowed;
@end

@interface Pilot (CoreDataGeneratedAccessors)

- (void)addSpaceshipsObject:(NSManagedObject *)value;
- (void)removeSpaceshipsObject:(NSManagedObject *)value;
- (void)addSpaceships:(NSSet *)values;
- (void)removeSpaceships:(NSSet *)values;

- (void)addUpgrades_allowedObject:(NSManagedObject *)value;
- (void)removeUpgrades_allowedObject:(NSManagedObject *)value;
- (void)addUpgrades_allowed:(NSSet *)values;
- (void)removeUpgrades_allowed:(NSSet *)values;

@end
