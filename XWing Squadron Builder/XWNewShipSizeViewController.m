//
//  XWNewShipSizeViewController.m
//  XWing builder
//
//  Created by Fiorio Christophe on 20/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "XWNewShipSizeViewController.h"
#import "ShipSize+DataModel.h"

@interface XWNewShipSizeViewController ()

@end

@implementation XWNewShipSizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    // Dismiss View Controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSString *aname = self.nameTextField.text; // Helper
    if (aname && aname.length) { // if a name has been entered
        // Create Entity
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShipSize" inManagedObjectContext:self.managedObjectContext];
        // get or create new faction with this name
        ShipSize* shipSize=[ShipSize getShipSizeWithName:aname withEntityDescription:entity inManagedObjectContext:self.managedObjectContext];
        if(!shipSize){
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:[NSString stringWithFormat:@"Ship Size %@ not saved",aname]
                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        // save will be done when quitting application (see AppDelegate), so dismiss view and go back to main screen
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else { // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your Ship Size needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
@end
