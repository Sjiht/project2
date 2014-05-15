//
//  ELLHomeController.m
//  project2-4
//
//  Created by Patrick de Koning on 5/7/14.
//  Copyright (c) 2014 PDKwebs. All rights reserved.
//

#import "ELLHomeController.h"
#import "ELLViewController.h"

@implementation ELLHomeController
- (void)viewDidLoad {
    NSLog(@"Loaded");
}

- (IBAction)newNormalGame:(id)sender {
    ELLViewController *gameController = [[ELLViewController alloc] initWithNibName:@"ELLViewController_iPhone" bundle:nil];
    [self.view addSubview:gameController.view];
    NSLog(@"New normal game");
}
@end
