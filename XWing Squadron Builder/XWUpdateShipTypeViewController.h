//
//  XWUpdateShipTypeViewController.h
//  XWing builder
//
//  Created by Fiorio Christophe on 20/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipType+DataModel.h"

@interface XWUpdateShipTypeViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) ShipType* shiptype;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end
