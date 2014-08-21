//
//  ShipSize.h
//  XWing Squadron Builder
//
//  Created by Fiorio Christophe on 21/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ShipType;

@interface ShipSize : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *shipTypes;
@property (nonatomic, retain) NSSet *upgradetypes;
@end

@interface ShipSize (CoreDataGeneratedAccessors)

- (void)insertObject:(ShipType *)value inShipTypesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromShipTypesAtIndex:(NSUInteger)idx;
- (void)insertShipTypes:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeShipTypesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInShipTypesAtIndex:(NSUInteger)idx withObject:(ShipType *)value;
- (void)replaceShipTypesAtIndexes:(NSIndexSet *)indexes withShipTypes:(NSArray *)values;
- (void)addShipTypesObject:(ShipType *)value;
- (void)removeShipTypesObject:(ShipType *)value;
- (void)addShipTypes:(NSOrderedSet *)values;
- (void)removeShipTypes:(NSOrderedSet *)values;
- (void)addUpgradetypesObject:(NSManagedObject *)value;
- (void)removeUpgradetypesObject:(NSManagedObject *)value;
- (void)addUpgradetypes:(NSSet *)values;
- (void)removeUpgradetypes:(NSSet *)values;

@end
