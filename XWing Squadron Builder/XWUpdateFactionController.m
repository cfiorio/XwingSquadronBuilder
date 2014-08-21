//
//  XWUpdateFactionController.m
//  XWing builder
//
//  Created by Fiorio Christophe on 19/08/2014.
//  Copyright (c) 2014 Fiorio Christophe. All rights reserved.
//

#import "XWUpdateFactionController.h"

@interface XWUpdateFactionController ()

@end

@implementation XWUpdateFactionController

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
    if (self.faction) {
        // Update Text Field
        [self.textField setText:self.faction.name];
    }
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
    NSString *aname = self.textField.text; // Helper
    if (aname && aname.length) { // if a name has been entered
        // Populate Record
        self.faction.name=aname; // save will be done when quitting application (see AppDelegate)
        // Pop View Controller
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your Faction needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
@end
