//
//  ELLHomeController.m
//  project2-4
//
//  Created by Patrick de Koning on 5/7/14.
//  Copyright (c) 2014 PDKwebs. All rights reserved.
//

#import "ELLHomeController.h"
#import "ELLViewController.h"
#import "ELLHighscoresController.h"

@implementation ELLHomeController
@synthesize wordLengthLabel;
@synthesize triesLabel;
@synthesize wordLength;
@synthesize endTries;

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (IBAction)wordLength:(UISlider *)sender {
    // Get the wordLength from the slider, making sure 4 is the lowest on the slider
    float wordLengthFloat = sender.value * 6 + 4;
    wordLength = (int) wordLengthFloat;
    
    // Display the sliders value
    wordLengthLabel.text = [NSString stringWithFormat:@"%d", wordLength];
}

- (IBAction)endTries:(UISlider *)sender {
    // Get the endTries from the slider, making sure 4 is the lowest on the slider
    float triesFloat = sender.value * 6 + 4;
    endTries = (int) triesFloat;
    
    // Display the sliders value
    triesLabel.text = [NSString stringWithFormat:@"%d", endTries];
}

- (IBAction)newNormalGame:(id)sender {
    // Display the game view
    ELLViewController *gameController = [[ELLViewController alloc] initWithNibName:@"ELLViewController_iPhone" bundle:nil];
    
    // It's a normal game
    gameController.evilGame = false;
    
    // Make standard values if the user doesn't change the sliders
    if (endTries > 0) {
        gameController.endTries = endTries;
    }
    else {
        gameController.endTries = 6;
    }
    
    if (wordLength > 0) {
        gameController.wordLength = wordLength;
    }
    else {
        gameController.wordLength = 6;
    }
    
    [self presentViewController:gameController animated:NO completion:nil];
}

- (IBAction)newEvilGame:(id)sender {
    // Display the game view
    ELLViewController *gameController = [[ELLViewController alloc] initWithNibName:@"ELLViewController_iPhone" bundle:nil];
    
    // It's an evil game
    gameController.evilGame = true;
    
    // Make standard values if the user doesn't change the sliders
    if (endTries > 0) {
        gameController.endTries = endTries;
    }
    else {
        gameController.endTries = 6;
    }
    
    if (wordLength > 0) {
        gameController.wordLength = wordLength;
    }
    else {
        gameController.wordLength = 6;
    }
    
    [self presentViewController:gameController animated:NO completion:nil];
}
- (IBAction)highscores:(id)sender {
    // Highscores button to display the highscores view
    ELLHighscoresController *highscoresController = [[ELLHighscoresController alloc] initWithNibName:@"Highscores" bundle:nil];
    [self presentViewController:highscoresController animated:NO completion:nil];
}
- (void)viewDidUnload {
    [self setWordLengthLabel:nil];
    [self setTriesLabel:nil];
    [super viewDidUnload];
}
@end
