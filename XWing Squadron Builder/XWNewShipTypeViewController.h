//
//  XWNewShipsViewController.h
//  XWing builder
//
//  Created by Fiorio Christophe on 19/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWNewShipTypeViewController : UIViewController

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *indexTextField;
@property (weak, nonatomic) IBOutlet UITextField *factionTextField;
@property (weak, nonatomic) IBOutlet UITextField *sizeTextField;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
