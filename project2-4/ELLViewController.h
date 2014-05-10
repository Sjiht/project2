//
//  ELLViewController.h
//  project2-4
//
//  Created by Patrick de Koning on 6/2/12.
//  Copyright (c) 2012 PDKwebs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELLViewController : UIViewController {
    // Text Fields
    IBOutlet UITextField *inputField;
    
    // Buttons
    IBOutlet UIButton *newgameButton;
    
    // Labels
    IBOutlet UILabel *triesLabel;
    IBOutlet UILabel *badLettersLabel;
    
    NSMutableArray *lettersArray;
    
    // Images
    IBOutlet UIImageView *hangmanImage;
}

// Auto generated buttons for letters

@property(strong) NSMutableArray *lettersArray;


- (IBAction)change:(id)sender;

@end
