//
//  ShipSize+DataModel.m
//  XWing builder
//
//  Created by Fiorio Christophe on 20/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "ShipSize+DataModel.h"
#import "XWAppDelegate.h"

@implementation ShipSize (DataModel)

// get a managedObject for a ShipSize with name aname
// if an entity with this name already exists in persistent storage, return a ShipSize initialized with this entity
// else alloc a new object and set its name to aname
+ (ShipSize*) getShipSizeWithName:(NSString*)aname withEntityDescription:(NSEntityDescription*)entity inManagedObjectContext:(NSManagedObjectContext*)context{
    ShipSize* retValue=nil;
    
    // if no name given, method fails
    if(!aname) return nil;
    // else we will search for a ShipSize with this name into the persistent store...
    
    // Fetching
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ShipSize"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"name",aname]];
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
        if([result count]>0){ // at least an object with such a name already exists
            retValue=result[0]; // get firstvalue as there should be only one such value
            //            NSLog(@"\n- getShipSizeWithName:%@ get an object:\n--->%@\n",aname,retValue);
        }
        else{ // no ShipSize with this name already exists, so create a new one
            retValue = [[ShipSize alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            if(retValue) retValue.name=aname;
            //            NSLog(@"\n- getShipSizeWithName:%@ creates a new object:\n--->%@\n",aname,retValue);
        }
    }
    return retValue;
}

// create a new managedObject for a ShipSize with name aname and initialize it
// if an entity with this name already exists in persistent storage, return nil as an error since
// we are trying to create a new ShipSize
// else alloc a new object and set its name to aname
// note: context is not saved
// note: this method use getShipSizeWithName method to initialize NSManagedObject and check data
+ (ShipSize*) newShipSize:(NSEntityDescription*)entity inContext:(NSManagedObjectContext*)context
                 withName:(NSString*)aname{
    ShipSize* ashipsize=nil;
    ashipsize=[ShipSize getShipSizeWithName:aname withEntityDescription:entity inManagedObjectContext:context];
    if(ashipsize)
        ashipsize.name=aname;
    return ashipsize;
}

#pragma mark - data initialization

// initialize all data
// note: should be called only once, since it add data already known... best used in testing phase
+ (void) initializeShipSizeData:(NSError**)error{
    NSLog(@"----- initializeShipSizeData");
    XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"ShipSize" inManagedObjectContext:managedObjectContext];
    //
    [ShipSize getShipSizeWithName:@"Normal" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    [ShipSize getShipSizeWithName:@"Big" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    [ShipSize getShipSizeWithName:@"Huge" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    [appDelegate saveManagedObjectContext:error];
}

#pragma mark - init

// description methods to output (NSLog) PSLibrary object
- (NSString *)description {
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%@",self.name];
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
