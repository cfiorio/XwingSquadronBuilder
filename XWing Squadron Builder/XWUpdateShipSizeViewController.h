//
//  XWUpdateShipSizeViewController.h
//  XWing builder
//
//  Created by Fiorio Christophe on 20/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipSize+DataModel.h"

@interface XWUpdateShipSizeViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ShipSize *shipsize;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
