//
//  XWing_Squadron_BuilderTests.m
//  XWing Squadron BuilderTests
//
//  Created by Fiorio Christophe on 21/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XWAppDelegate.h"
#import "Faction+DataModel.h"
#import "ShipSize+DataModel.h"
#import "ShipType+DataModel.h"

@interface XWing_Squadron_BuilderTests : XCTestCase

@end

@implementation XWing_Squadron_BuilderTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDataInitialization {
    NSError* error=nil;
    [Faction initializeFactionData:&error];
    XCTAssertNil(error,@"Unable to save managed object context for Faction initialization: %@, %@",error, error.localizedDescription);
    [ShipSize initializeShipSizeData:&error];
    XCTAssertNil(error,@"Unable to save managed object context for ShipSize initialization: %@, %@",error, error.localizedDescription);
    [ShipType initializeShipTypesData:&error];
    XCTAssertNil(error,@"Unable to save managed object context for Ship Type initialization: %@, %@",error, error.localizedDescription);
}

- (void)testShipSize
{
    XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"ShipSize" inManagedObjectContext:managedObjectContext];
    NSError *error=nil;
    
    NSLog(@"\n*** ShipSize(Model) test");
    // Normal Shipsize initialization
    NSString *sizeName = @"Normal";
    ShipSize *normal = [ShipSize getShipSizeWithName:sizeName withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    XCTAssertNotNil(normal,@"ShipSize init failed");
    XCTAssertEqualObjects(normal.name,sizeName,@"ShipSize name not equal to %@",sizeName);
    NSLog(@"ShipSize = %@",normal);
    // save data
    XCTAssertTrue([appDelegate saveManagedObjectContext:&error],@"Unable to save managed object context: %@, %@",error, error.localizedDescription);
    
    // All ShipSizes
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ShipSize"];
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    XCTAssertNil(error,@"ShipSize fetching failed");
    if (!fetchError) {
        NSLog(@"ShipSizes=\n%@",result);
    }
}


- (void)testFaction
{
    XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Faction" inManagedObjectContext:managedObjectContext];
    NSError *error=nil;
    
    NSLog(@"\n*** Faction(Model) test");
    // empire faction initialization
    Faction *empire = [Faction getFactionWithName:@"Empire" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    XCTAssertNotNil(empire,@"Faction init failed");
    XCTAssertEqualObjects(empire.name,@"Empire",@"Faction name not equal to %@",@"Empire");
    NSLog(@"Faction = %@",empire);
    // rebels faction initialization
    Faction *rebels = [Faction getFactionWithName:@"Rebels" withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    XCTAssertNotNil(rebels,@"Faction init failed");
    XCTAssertEqualObjects(rebels.name,@"Rebels",@"Faction name not equal to %@",@"Rebels");
    NSLog(@"XWFaction rebels= %@",rebels);
    
    // save data
    XCTAssertTrue([appDelegate saveManagedObjectContext:&error],@"Unable to save managed object context: %@, %@",error, error.localizedDescription);
    
    // verifiying data inserted
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    XCTAssertNil(error,@"Unable to save managed object context: %@, %@",error, error.localizedDescription);
    NSLog(@"%@", result);
}

- (void)testShipType
{
    XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Size" inManagedObjectContext:managedObjectContext];
    NSError *error=nil;
    
    NSLog(@"\n*** Size(Model) test");
    // X-Wing Ship Type initialization
    NSString *shipTypeName = @"X-Wing";
    ShipType *xwing = [ShipType getShipTypeWithName:shipTypeName withEntityDescription:entityDescription inManagedObjectContext:managedObjectContext];
    XCTAssertNotNil(xwing,@"Ship Type init failed");
    XCTAssertEqualObjects(xwing.name,shipTypeName,@"Ship type name not equal to %@",shipTypeName);
    NSLog(@"ShipType = %@",xwing);
    // save data
    XCTAssertTrue([appDelegate saveManagedObjectContext:&error],@"Unable to save managed object context: %@, %@",error, error.localizedDescription);
    
    // All Ship types
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ShipType"];
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"faction" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]]];
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    XCTAssertNil(error,@"Ship types fetching failed");
    if (!fetchError) {
        NSLog(@"Ship types=\n%@",result);
    }
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

@end
