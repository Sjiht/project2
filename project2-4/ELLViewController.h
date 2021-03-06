//
//  ELLViewController.h
//  project2-4
//
//  Created by Patrick de Koning on 6/2/12.
//  Copyright (c) 2012 PDKwebs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELLNormalGame.h"
#import "ELLEvilGame.h"

@interface ELLViewController : UIViewController {
    // Text Fields
    IBOutlet UITextField *inputField;
    
    // Buttons
    IBOutlet UIButton *newgameButton;
    IBOutlet UIButton *menuButton;
    
    // Labels
    IBOutlet UILabel *triesLabel;
    IBOutlet UILabel *badLettersLabel;
    IBOutlet UILabel *triesTextLabel;
    IBOutlet UILabel *badLettersTextLabel;
    
    NSMutableArray *lettersArray;
    
    // Images
    IBOutlet UIImageView *hangmanImage;
}

// Auto generated buttons for letters

@property(strong) NSMutableArray *lettersArray;
@property BOOL evilGame;
@property int wordLength;
@property int endTries;

- (IBAction)change:(id)sender;
- (IBAction)menu:(id)sender;

@end
