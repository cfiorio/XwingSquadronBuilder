//
//  XWNewFactionViewController.h
//  XWing builder
//
//  Created by Fiorio Christophe on 19/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface XWNewFactionViewController : UIViewController <UITextFieldDelegate>

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
