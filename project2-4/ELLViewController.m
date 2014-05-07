//
//  ELLViewController.m
//  project2-4
//
//  Created by Patrick de Koning on 6/2/12.
//  Copyright (c) 2012 PDKwebs. All rights reserved.
//

#import "ELLViewController.h"

@interface ELLViewController ()

@end

@implementation ELLViewController

// Create integer variables
int fieldLetter1Solved;
int fieldLetter2Solved;
int fieldLetter3Solved;
int fieldLetter4Solved;
int fieldLetter5Solved;
int fieldLetter6Solved;
int goodTries;
int badTries;
int gameEnd;
int endTries = 200;
int wordLength = 6;

// Create empty string variables
NSString *badLetters = @"";
NSString *word = @"";

- (NSString *)chooseWord {
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    NSArray *array2 = [dictionary valueForKey:@"array"];
    
    // Pick a random word from the array
    NSInteger *randomIndex = arc4random() % [array2 count];
    NSString *word = [array2 objectAtIndex:randomIndex];
    NSLog(@"%@", word);
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
        NSString *wordLetter1 = [word substringWithRange:NSMakeRange(0, 1)];
        NSString *wordLetter2 = [word substringWithRange:NSMakeRange(1, 1)];
        NSString *wordLetter3 = [word substringWithRange:NSMakeRange(2, 1)];
        NSString *wordLetter4 = [word substringWithRange:NSMakeRange(3, 1)];
        NSString *wordLetter5 = [word substringWithRange:NSMakeRange(4, 1)];
        NSString *wordLetter6 = [word substringWithRange:NSMakeRange(5, 1)];
        
        int fieldLength = [inputField.text length];
        NSString *fieldLetter = @"";
        fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
        
        [testButton setTitle:[NSString stringWithFormat:@"%s", fieldLetter] forState:UIControlStateNormal];
        
        // If current letter is equal to this particular letter
        if ([fieldLetter isEqualToString:(wordLetter1)]) {
            //[letter1Button setTitle:fieldLetter forState:(UIControlStateNormal)];
            [letter1Button setTitle:[NSString stringWithFormat:@"%s", fieldLetter] forState:UIControlStateNormal];
            fieldLetter1Solved = 1;
        }
        if ([fieldLetter isEqualToString:(wordLetter2)]) {
            [letter2Button setTitle:fieldLetter forState:(UIControlStateNormal)];
            fieldLetter2Solved = 1;
        }
        if ([fieldLetter isEqualToString:(wordLetter3)]) {
            [letter3Button setTitle:fieldLetter forState:(UIControlStateNormal)];
            fieldLetter3Solved = 1;
        }
        if ([fieldLetter isEqualToString:(wordLetter4)]) {
            [letter4Button setTitle:fieldLetter forState:(UIControlStateNormal)];
            fieldLetter4Solved = 1;
        }
        if ([fieldLetter isEqualToString:(wordLetter5)]) {
            [letter5Button setTitle:fieldLetter forState:(UIControlStateNormal)];
            fieldLetter5Solved = 1;
        }
        if ([fieldLetter isEqualToString:(wordLetter6)]) {
            [letter6Button setTitle:fieldLetter forState:(UIControlStateNormal)];
            fieldLetter6Solved = 1;
        }
        
        // If current letter is equal to one of the letters
        if ([fieldLetter isEqualToString:(wordLetter1)]
            || [fieldLetter isEqualToString:(wordLetter2)]
            || [fieldLetter isEqualToString:(wordLetter3)]
            || [fieldLetter isEqualToString:(wordLetter4)]
            || [fieldLetter isEqualToString:(wordLetter5)]
            || [fieldLetter isEqualToString:(wordLetter6)]) {
            goodTries++;
        }
        else {
            // Check if pressed letter has already been pressed
            if ([badLetters rangeOfString:fieldLetter].location == NSNotFound) {
                badTries++;
                badLetters = [NSString stringWithFormat:@"%@%@", badLetters, fieldLetter];
            }
            // Display next image
            if (badTries == 1) {
                UIImage *hangmanImageNow = [UIImage imageNamed:@"2.png"];
                [hangmanImage setImage:hangmanImageNow];
            }
            if (badTries == 2) {
                UIImage *hangmanImageNow = [UIImage imageNamed:@"3.png"];
                [hangmanImage setImage:hangmanImageNow];
            }
            if (badTries == 3) {
                UIImage *hangmanImageNow = [UIImage imageNamed:@"4.png"];
                [hangmanImage setImage:hangmanImageNow];
            }
            if (badTries == 4) {
                UIImage *hangmanImageNow = [UIImage imageNamed:@"5.png"];
                [hangmanImage setImage:hangmanImageNow];
            }
            if (badTries == 5) {
                UIImage *hangmanImageNow = [UIImage imageNamed:@"6.png"];
                [hangmanImage setImage:hangmanImageNow];
            }
            if (badTries == 6) {
                UIImage *hangmanImageNow = [UIImage imageNamed:@"7.png"];
                [hangmanImage setImage:hangmanImageNow];
            }
            //}
        }
        
        // If everything is solved
        if (fieldLetter1Solved == 1
            && fieldLetter2Solved == 1
            && fieldLetter3Solved == 1
            && fieldLetter4Solved == 1
            && fieldLetter5Solved == 1
            && fieldLetter6Solved == 1) {    
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
    [letter1Button setTitle:@"" forState:(UIControlStateNormal)];
    [letter2Button setTitle:@"" forState:(UIControlStateNormal)];
    [letter3Button setTitle:@"" forState:(UIControlStateNormal)];
    [letter4Button setTitle:@"" forState:(UIControlStateNormal)];
    [letter5Button setTitle:@"" forState:(UIControlStateNormal)];
    [letter6Button setTitle:@"" forState:(UIControlStateNormal)];
    
    // Reset labels
    [triesLabel setText:@"0"];
    [badLettersLabel setText:@""];
    
    // Reset integer variables
    fieldLetter1Solved = 0;
    fieldLetter2Solved = 0;
    fieldLetter3Solved = 0;
    fieldLetter4Solved = 0;
    fieldLetter5Solved = 0;
    fieldLetter6Solved = 0;
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
    
    int startWidth = 320 / wordLength - 30;
    int x = startWidth / 2;
    
    // self.letterArray aanmaken in header file
    // 
    
    for (int i=1; i<=wordLength; i++) {
        UIButton *letter1Button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        letter1Button.frame = CGRectMake(x, 25, 30, 30);
        //letterArray append:letter1button
        [self.view addSubview:letter1Button];
        x = x + 30 + startWidth;
    }
    
    UIButton *testButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    testButton.frame = CGRectMake(0, 0, 30, 30);
    [self.view addSubview:testButton];
    self->testButton = testButton;
    
    [self.view addSubview:letter1Button];
    self->letter1Button = letter1Button;
    x = x + 30 + startWidth;
    
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
