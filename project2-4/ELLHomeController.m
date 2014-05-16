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

- (void)removeUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}

- (void)viewDidLoad {

}

- (IBAction)wordLength:(UISlider *)sender {
    float wordLengthFloat = sender.value * 6 + 4;
    wordLength = (int) wordLengthFloat;
    wordLengthLabel.text = [NSString stringWithFormat:@"%d", wordLength];
}

- (IBAction)endTries:(UISlider *)sender {
    float triesFloat = sender.value * 6 + 4;
    endTries = (int) triesFloat;
    triesLabel.text = [NSString stringWithFormat:@"%d", endTries];
}

- (IBAction)newNormalGame:(id)sender {
    ELLViewController *gameController = [[ELLViewController alloc] initWithNibName:@"ELLViewController_iPhone" bundle:nil];
    gameController.evilGame = false;
    
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
    
    [self presentViewController:gameController animated:YES completion:nil];
    NSLog(@"New normal game");
}

- (IBAction)newEvilGame:(id)sender {
    ELLViewController *gameController = [[ELLViewController alloc] initWithNibName:@"ELLViewController_iPhone" bundle:nil];
    gameController.evilGame = true;
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
    
    [self presentViewController:gameController animated:YES completion:nil];
    NSLog(@"New evil game");
}
- (IBAction)highscores:(id)sender {
    ELLHighscoresController *highscoresController = [[ELLHighscoresController alloc] initWithNibName:@"Highscores" bundle:nil];
    [self presentViewController:highscoresController animated:YES completion:nil];
}
- (void)viewDidUnload {
    [self setWordLengthLabel:nil];
    [self setTriesLabel:nil];
    [super viewDidUnload];
}
@end
