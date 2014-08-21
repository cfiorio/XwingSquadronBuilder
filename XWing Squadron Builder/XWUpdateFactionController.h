//
//  XWUpdateFactionController.h
//  XWing builder
//
//  Created by Fiorio Christophe on 19/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Faction+DataModel.h"

@interface XWUpdateFactionController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Faction *faction;

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
