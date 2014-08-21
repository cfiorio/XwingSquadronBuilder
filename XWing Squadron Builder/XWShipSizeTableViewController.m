//
//  XWShipSizeTableViewController.m
//  XWing builder
//
//  Created by Fiorio Christophe on 20/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "XWAppDelegate.h"

#import "XWShipSizeTableViewController.h"
#import "XWShipSizeTableViewCell.h"

#import "XWNewShipSizeViewController.h"
#import "XWUpdateShipSizeViewController.h"

#import "ShipSize+DataModel.h"


@interface XWShipSizeTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *selectedShipSizes; // to handle selected ship sizes

@end

@implementation XWShipSizeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        if(!self.managedObjectContext){
            XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            self.managedObjectContext = appDelegate.managedObjectContext;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // -------------------------------------------------
    // *** Initialize managedObjectContext property ***
    if(!self.managedObjectContext){
        XWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }
    
    // -------------------------------------------------
    // *** Initialize FetchResultController         ***
    
    // initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ShipSize"];
    // add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    // initialize Fetched Results Controller
    self.fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil cacheName:nil];
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    
    // -------------------------------------------------
    // *** Perform Fetch                            ***
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    // Return the number of rows in the section.
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWShipSizeTableViewCell *cell =
        (XWShipSizeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ShipSizeTableViewCell"
                                                                   forIndexPath:indexPath];
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShipSize *shipsize = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if(shipsize) {
            [self.fetchedResultsController.managedObjectContext deleteObject:shipsize];
        }
    }
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table View Delegate Methods
 
 - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 // Store Selection
     self.selectedShipSizes=indexPath;
     return indexPath;
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     // end of selection
     self.selectedShipSizes=nil;
 }
 

#pragma mark - FetchResultDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(XWShipSizeTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"NewShipSizeSegue"]) {
        // Obtain Reference to View Controller
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
        XWNewShipSizeViewController *newShipSizeController = (XWNewShipSizeViewController *)[nc topViewController];
        // Configure View Controller
        newShipSizeController.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"UpdateShipSizeSegue"]) {
        XWUpdateShipSizeViewController *updateShipSizeController = // Obtain Reference to View Controller
            (XWUpdateShipSizeViewController *)[segue destinationViewController];
        // Configure View Controller
        updateShipSizeController.managedObjectContext = self.managedObjectContext;
        // if there is a selected faction
        if (self.selectedShipSizes) {  // set faction of update controller so it can handle modifications
            ShipSize *record = // Fetch Record
            [self.fetchedResultsController objectAtIndexPath:self.selectedShipSizes];
            if (record) updateShipSizeController.shipsize=record;
        }
    }
}

#pragma mark - Helper methods

- (void)configureCell:(XWShipSizeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Fetch Record
    ShipSize *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Update Cell
    [cell.nameLabel setText:record.name];
}


@end
