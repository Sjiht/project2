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
int wordLength = 6;
NSMutableArray *wordLetterArray;

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
        int fieldLength = [inputField.text length];
        NSString *fieldLetter = @"";
        fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
        
        for (int i=0; i<wordLength; i++){
            NSString *wordLetter = [word substringWithRange:NSMakeRange(i, 1)];
                
            // If current letter is equal to this particular letter
            if ([fieldLetter isEqualToString:(wordLetter)]) {
                [[self.lettersArray objectAtIndex:i] setTitle:fieldLetter forState:(UIControlStateNormal)];
                fieldLettersSolved++;
                goodTries++;
            }
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
    [[self.lettersArray objectAtIndex:0] setTitle:@"" forState:(UIControlStateNormal)];
    [[self.lettersArray objectAtIndex:1] setTitle:@"" forState:(UIControlStateNormal)];
    [[self.lettersArray objectAtIndex:2] setTitle:@"" forState:(UIControlStateNormal)];
    [[self.lettersArray objectAtIndex:3] setTitle:@"" forState:(UIControlStateNormal)];
    [[self.lettersArray objectAtIndex:4] setTitle:@"" forState:(UIControlStateNormal)];
    [[self.lettersArray objectAtIndex:5] setTitle:@"" forState:(UIControlStateNormal)];
    
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
    NSLog(@"HOI");

    int startWidth = 320 / wordLength - 30;
    int x = startWidth / 2;
    
    for (int i=1; i<=wordLength; i++) {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        UIButton *letterButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        letterButton.frame = CGRectMake(x, 25, 30, 30);
        [self.view addSubview:letterButton];
        [self.lettersArray addObject:letterButton];
        
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
        
        UIButton *testButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        testButton.frame = CGRectMake(x, 25, 30, 30);
        [self.view addSubview:testButton];
        self->testButton = testButton;
        [self.view addSubview:letter1Button];
        self->letter1Button = letter1Button;
>>>>>>> FETCH_HEAD
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
