//
//  ELLViewController.m
//  project2-4
//
//  Created by Patrick de Koning on 6/2/12.
//  Copyright (c) 2012 PDKwebs. All rights reserved.
//

#import "ELLViewController.h"


@implementation ELLViewController
@synthesize lettersArray;

// Create integer variables
int fieldLettersSolved;
int goodTries;
int badTries;
int gameEnd;
int endTries = 6;
int wordLength = 3;
NSMutableArray *wordLetterArray;

// Create empty string variables
NSString *badLetters = @"";
NSString *word = @"";

- (NSString *)chooseWord {
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    NSArray *array2 = [dictionary valueForKey:@"array"];
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    for (NSString *key in array2) {
        int length = [key length];
        if (length == wordLength) {
            [array3 addObject:key];
        }
        
    }
    // Pick a random word from the array
    NSInteger *randomIndex = arc4random() % [array3 count];
    NSString *word = [array3 objectAtIndex:randomIndex];
    return word;
}

- (NSString *)checkWord {
    if (word == @"") {
        word = [self chooseWord];
        return word;
    }
    else {
        return word;
    }
    
}
- (IBAction)change:(id)sender {
    if (gameEnd != 1) {
        word = [self checkWord];
        int fieldLength = [inputField.text length];
        NSString *fieldLetter = @"";
        fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
        
        bool correctLetterCheck = false;
        
        for (int i=0; i<wordLength; i++) {
            NSString *wordLetter = [word substringWithRange:NSMakeRange(i, 1)];
                
            // If current letter is equal to this particular letter
            if ([fieldLetter isEqualToString:(wordLetter)]) {
                [[self.lettersArray objectAtIndex:i] setTitle:fieldLetter forState:(UIControlStateNormal)];
                fieldLettersSolved++;
                goodTries++;
                correctLetterCheck = true;
            }
        }
        
        if (correctLetterCheck == false) {
            // Check if pressed letter has already been pressed
            if ([badLetters rangeOfString:fieldLetter].location == NSNotFound) {
                badTries++;
                badLetters = [NSString stringWithFormat:@"%@%@", badLetters, fieldLetter];
            }
            // Display next image
            for (int i=1; i<=6; i++) {
                if (badTries == i) {
                    NSString *hangmanImageName = [NSString stringWithFormat:@"%d.png", i + 1];
                    UIImage *hangmanImageNow = [UIImage imageNamed:hangmanImageName];
                    [hangmanImage setImage:hangmanImageNow];
                }
            }
        }
                
        // If everything is solved
        if (fieldLettersSolved == wordLength) {
            // Show Alert (win)
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:    @"You won!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        // Show number of tries
        [triesLabel setText:[NSString stringWithFormat:@"%d / %d", badTries, endTries]];
        
        // Show bad letters
        [badLettersLabel setText:[NSString stringWithFormat:@"%@", badLetters]];
        
        if (!(badTries < endTries)) {
            // Show Alert (lose)
            NSString *alertString = [NSString stringWithFormat:@"You lose! The word was: %@", word];
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Ahh!"
                                                              message:alertString
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [myAlert show];
            gameEnd = 1;
        }
    }
}

- (void)newgame:(id)sender {
    // Reset buttons
    for (int i=0; i<wordLength; i++) {
        [[self.lettersArray objectAtIndex:i] setTitle:@"" forState:(UIControlStateNormal)];
    }
    
    // Reset labels
    [triesLabel setText:@"0"];
    [badLettersLabel setText:@""];
    
    // Reset integer variables
    fieldLettersSolved = 0;
    goodTries = 0;
    badTries = 0;
    gameEnd = 0;
    
    // Reset string variables
    badLetters = @"";
    //VICTOR: UIButton * letter = letterArray[1]
    // Reset word
    word = @"";
    
    // Display basic image
    UIImage *hangmanImageNow = [UIImage imageNamed:@"1.png"];
    [hangmanImage setImage:hangmanImageNow];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lettersArray = [[NSMutableArray alloc] init];
    int startWidth = 320 / wordLength - 30;
    int x = startWidth / 2;
    
    for (int i=1; i<=wordLength; i++) {
        UIButton *letterButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        letterButton.frame = CGRectMake(x, 25, 30, 30);
        [self.view addSubview:letterButton];
        [self.lettersArray addObject:letterButton];
        x = x + 30 + startWidth;
    }
    
    // hide input field by default
    inputField.hidden = YES;
    
    // display keyboard
    [inputField becomeFirstResponder];
    
    // Set label defaults
    [triesLabel setText:@"0"];
    
    // Display basic image
    UIImage *hangmanImageNow = [UIImage imageNamed:@"1.png"];
    [hangmanImage setImage:hangmanImageNow];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
