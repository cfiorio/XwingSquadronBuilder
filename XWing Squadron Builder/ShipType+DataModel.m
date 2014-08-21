//
//  ShipType+DataModel.m
//  XWing builder
//
//  Created by Fiorio Christophe on 20/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "ShipType+DataModel.h"
#import "XWAppDelegate.h"
#import "Faction+DataModel.h"
#import "ShipSize+DataModel.h"

@implementation ShipType (DataModel)

// get a managedObject for a ShipType with name aname
// if an entity with this name already exists in persistent storage, return a ShipType initialized with this entity
// else alloc a new object and set its name to aname
+ (ShipType*) getShipTypeWithName:(NSString*)aname withEntityDescription:(NSEntityDescription*)entity inManagedObjectContext:(NSManagedObjectContext*)context{
    ShipType* retValue=nil;
    
    // if no name given, method fails
    if(!aname) return nil;
    // else we will search for a ShipType with this name into the persistent store...
    
    // Fetching
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ShipType"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name",aname]];
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
        if([result count]>0){ // at least an object with such a name already exists
            retValue=result[0]; // get firstvalue as there should be only one such value
            //            NSLog(@"\n- getShipTypeWithName:%@ get an object:\n--->%@\n",aname,retValue);
        }
        else{ // no ShipType with this name already exists, so create a new one
            retValue = [[ShipType alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            if(retValue) retValue.name=aname;
            //            NSLog(@"\n- getShipWithName:%@ creates a new object:\n--->%@\n",aname,retValue);
        }
    }
    return retValue;
}

// create a new managedObject for a ship type with name aname and initialize it with faction afaction and size asize
// if an entity with this name already exists in persistent storage, return nil as an error since
// we are trying to create a new ShipType initialized with this entity
// else alloc a new object and set its name to aname, its faction to afaction and its size to asize
// note: context is not saved
// note: this method use getShipTypeWithName method to initialize NSManagedObject and check data
+ (ShipType*) newShipType:(NSEntityDescription*)entity inContext:(NSManagedObjectContext*)context
         withName:(NSString*)aname inFaction:(Faction*)afaction ofSize:(ShipSize*)asize indexedBy:(int)anindex{
    ShipType* ashiptype=nil;
    ashiptype=[ShipType getShipTypeWithName:aname withEntityDescription:entity inManagedObjectContext:context];
    if(ashiptype){
        if( (ashiptype.faction) || (ashiptype.size) ) //a ship type with a already defined size or faction exists
            ashiptype=nil;  // so we cannot create it
        else{           // set faction and size accordingly to parameters
            ashiptype.name    = aname;
            ashiptype.faction = afaction;
            ashiptype.size    = asize;
            ashiptype.index   = anindex;
        }
    }
    return ashiptype;
}

#pragma mark - data initialization

// initialize all ship types with data
// note: should be called only once, since it add data already known... best used in testing phase
+ (void) initializeShipTypesData:(NSError**)error{
    NSLog(@"------ initializeShipTypesData");
    XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *factionEntity = [NSEntityDescription entityForName:@"Faction" inManagedObjectContext:managedObjectContext];
    NSEntityDescription *shipTypeEntity = [NSEntityDescription entityForName:@"ShipType" inManagedObjectContext:managedObjectContext];
    NSEntityDescription *sizeEntity = [NSEntityDescription entityForName:@"ShipSize" inManagedObjectContext:managedObjectContext];
    //
    Faction* empire = [Faction getFactionWithName:@"Empire" withEntityDescription:factionEntity inManagedObjectContext:managedObjectContext];
    Faction* rebels = [Faction getFactionWithName:@"Rebels" withEntityDescription:factionEntity inManagedObjectContext:managedObjectContext];
    ShipSize* normal = [ShipSize getShipSizeWithName:@"Normal" withEntityDescription:sizeEntity inManagedObjectContext:managedObjectContext];
    ShipSize* big    = [ShipSize getShipSizeWithName:@"Big" withEntityDescription:sizeEntity inManagedObjectContext:managedObjectContext];
    ShipSize* huge   = [ShipSize getShipSizeWithName:@"Huge" withEntityDescription:sizeEntity inManagedObjectContext:managedObjectContext];
    //
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"X-Wing" inFaction:rebels ofSize:normal indexedBy:1];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Y-Wing" inFaction:rebels ofSize:normal indexedBy:2];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"A-Wing" inFaction:rebels ofSize:normal indexedBy:3];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"B-Wing" inFaction:rebels ofSize:normal indexedBy:4];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"E-Wing" inFaction:rebels ofSize:normal indexedBy:5];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Z-95 Headhunter" inFaction:rebels ofSize:normal indexedBy:6];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"HWK-290" inFaction:rebels ofSize:normal indexedBy:7];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"YT-1300" inFaction:rebels ofSize:big indexedBy:8];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"YT-2400 Freighter" inFaction:rebels ofSize:big indexedBy:9];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"GR-75 Medium transport" inFaction:rebels ofSize:huge indexedBy:10];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"CR90 Corvette" inFaction:rebels ofSize:huge indexedBy:11];
    //
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Tie Fighter" inFaction:empire ofSize:normal indexedBy:1];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Tie Advanced" inFaction:empire ofSize:normal indexedBy:2];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Tie Interceptor" inFaction:empire ofSize:normal indexedBy:3];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Tie Bomber" inFaction:empire ofSize:normal indexedBy:4];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Tie Defender" inFaction:empire ofSize:normal indexedBy:5];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Tie Phantom" inFaction:empire ofSize:normal indexedBy:6];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Lambda-class Shuttle" inFaction:empire ofSize:big indexedBy:7];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"V-49 Decimator" inFaction:empire ofSize:big indexedBy:8];
    [ShipType newShipType:shipTypeEntity inContext:managedObjectContext withName:@"Firespray-31" inFaction:empire ofSize:big indexedBy:9];
    //
    [appDelegate saveManagedObjectContext:error];
}

#pragma mark - init

// description methods to output (NSLog) PSLibrary object
- (NSString *)description {
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%d. %@ (%@) - %@\n",self.index,self.name,self.faction,self.size];
//    NSMutableString* desc = [NSMutableString stringWithFormat:@"ShipType(DataModel):"];
//    [desc appendFormat:@"%@\n",[[[[self objectID] description] componentsSeparatedByString:@" "] objectAtIndex:0]];
//    [desc appendFormat:@"%@ (%@) - %@\n",self.name,self.faction,self.size];
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
