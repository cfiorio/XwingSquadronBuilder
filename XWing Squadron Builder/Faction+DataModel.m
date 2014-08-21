//
//  Faction+DataModel.m
//  XWing builder
//
//  Created by Fiorio Christophe on 18/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "Faction+DataModel.h"
#import "XWAppDelegate.h"

@implementation Faction (DataModel)

// get a managedObject for a faction with name aname
// if an entity with this name already exists in persistent storage, return a Faction initialized with this entity
// else alloc a new object and set its name to aname
+ (Faction*) getFactionWithName:(NSString*)aname withEntityDescription:(NSEntityDescription*)entity inManagedObjectContext:(NSManagedObjectContext*)context{
    Faction* retValue=nil;

    // if no name given, method fails
    if(!aname) return nil;
    // else we will search for a faction with this name into the persistent store...
    
    // Fetching
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Faction"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name",aname]];
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
        if([result count]>0){ // at least an object with such a name already exists
            retValue=result[0]; // get firstvalue as there should be only one such value
        }
        else{ // no faction with this name already exists, so create a new one
            retValue = [[Faction alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            if(retValue) retValue.name=aname;
        }
    }
    return retValue;
}

// create a new managedObject for a Faction with name aname and initialize it
// if an entity with this name already exists in persistent storage, return nil as an error since
// we are trying to create a new Faction
// else alloc a new object and set its name to aname
// note: context is not saved
// note: this method use getFactionWithName method to initialize NSManagedObject and check data
+ (Faction*) newFaction:(NSEntityDescription*)entity inContext:(NSManagedObjectContext*)context
         withName:(NSString*)aname{
    Faction* afaction=nil;
    afaction=[Faction getFactionWithName:aname withEntityDescription:entity inManagedObjectContext:context];
    if(afaction)
        afaction.name=aname;
    return afaction;
}

#pragma mark - data initialization

// initialize all data
// note: should be called only once, since it add data already known... best used in testing phase
+ (void) initializeFactionData:(NSError**)error{
    NSLog(@"----- initializeFactionData");
    XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Faction" inManagedObjectContext:managedObjectContext];
    //
    [Faction getFactionWithName:@"Empire" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    [Faction getFactionWithName:@"Rebels" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    [Faction getFactionWithName:@"Scum and Villainy" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    [appDelegate saveManagedObjectContext:error];
}

#pragma mark - init

// description methods to output (NSLog) PSLibrary object
- (NSString *)description {
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%@",self.name];
//    NSMutableString* desc = [NSMutableString stringWithFormat:@"Faction(DataModel):"];
//    [desc appendFormat:@"%@\n",[[[[self objectID] description] componentsSeparatedByString:@" "] objectAtIndex:0]];
//    [desc appendFormat:@"%@\n",self.name];
    return desc;
}


// should not override init methods in managedObject, so instead override
// awakeFromInsert: invoked only once in the lifetime of an object—when it is first created.
- (void) awakeFromInsert
{
    [super awakeFromInsert];
}

// another way of perform some initialization is to override awakeFromFetch,
// for example to compute transient value
// awakeFromFetch: invoked when an object is re-initialized from a persistent store (during a fetch)
- (void) awakeFromFetch
{
    [super awakeFromFetch];
}


@end

//@implementation Faction (CoreDataGeneratedAccessors)

//#pragma mark -
//#pragma mark - data relationships
//#pragma mark -
//
//#pragma mark data relationships: Ships
//
//- (void)addShipsObject:(NSManagedObject *)value {
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"ships" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"ships"] addObject:value];
//    [self didChangeValueForKey:@"ships" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//}
//
//- (void)removeShipsObject:(NSManagedObject *)value{
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"ships" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"ships"] removeObject:value];
//    [self didChangeValueForKey:@"ships" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//}
//
//- (void)addShips:(NSSet *)values{
//    [self willChangeValueForKey:@"ships" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"ships"] unionSet:values];
//    [self didChangeValueForKey:@"ships" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//}
//
//- (void)removeShips:(NSSet *)values {
//    [self willChangeValueForKey:@"ships" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"ships"] minusSet:values];
//    [self didChangeValueForKey:@"ships" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//}
//
//#pragma mark - data relationships: Squadron
//
//- (void)addSquadronsObject:(NSManagedObject *)value {
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"squadrons"] addObject:value];
//    [self didChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//}
//
//- (void)removeSquadronsObject:(NSManagedObject *)value{
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"squadrons"] removeObject:value];
//    [self didChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//}
//
//- (void)addSquadrons:(NSSet *)values{
//    [self willChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"squadrons"] unionSet:values];
//    [self didChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//}
//
//- (void)removeSquadrons:(NSSet *)values{
//    [self willChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"squadrons"] minusSet:values];
//    [self didChangeValueForKey:@"squadrons" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//}

//@end
