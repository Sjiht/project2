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
    IBOutlet UIButton *letter1Button;
    IBOutlet UIButton *letter2Button;
    IBOutlet UIButton *letter3Button;
    IBOutlet UIButton *letter4Button;
    IBOutlet UIButton *letter5Button;
    IBOutlet UIButton *letter6Button;
    IBOutlet UIButton *letter7Button;
    IBOutlet UIButton *letter8Button;
    IBOutlet UIButton *letter9Button;
    IBOutlet UIButton *letter10Button;
    IBOutlet UIButton *testButton;
    
    
    
    // Labels
    IBOutlet UILabel *triesLabel;
    IBOutlet UILabel *badLettersLabel;
    
    // Images
    IBOutlet UIImageView *hangmanImage;
}

- (IBAction)change:(id)sender;

@end
