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
int endTries = 10;
int wordLength = 7;

// Create Mutable arrays
NSMutableArray *wordLetterArray;
NSMutableArray *guessedLettersArray;
NSMutableArray *array2;

// Create empty string variables
NSString *tempGoodLetters = @"";
NSString *goodLetters = @"";
NSString *badLetters = @"";
NSString *word = @"";

// Create booleans
bool gameEnd;
bool evilGame = true;

- (NSString *)chooseNormalWord {
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    NSMutableArray *array2 = [dictionary valueForKey:@"array"];
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    for (NSString *key in array2) {
        NSString *keyLowercase = [key lowercaseString];
        int length = [key length];
        if (length == wordLength) {
            [array3 addObject:keyLowercase];
        }
    }
    // Pick a random word from the array
    NSInteger *randomIndex = arc4random() % [array3 count];
    NSString *word = [array3 objectAtIndex:randomIndex];
    return word;
}

- (NSString *)chooseEvilWord {
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    for (NSString *key in array2) {
        NSString *keyLowercase = [key lowercaseString];
        int length = [key length];
        if (length == wordLength) {
            [array3 addObject:keyLowercase];
        }
    }
    
    int fieldLength = [inputField.text length];
    NSString *fieldLetter = @"";
    fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
    
    NSMutableArray *array4 = [[NSMutableArray alloc] init];
    NSMutableArray *array5 = [[NSMutableArray alloc] init];
    NSMutableArray *array6 = [[NSMutableArray alloc] init];
    NSMutableArray *array7 = [[NSMutableArray alloc] init];
    NSMutableArray *array8 = [[NSMutableArray alloc] init];
    NSMutableArray *wordlettersArray = [[NSMutableArray alloc] init];
    for (int i=0; i<wordLength; i++) {
        [wordlettersArray insertObject:@"" atIndex:i];
    }
    
    NSNumber *someNumber = [NSNumber numberWithInt:0];
    for (int i=0; i<wordLength; i++) {
        [array7 addObject:someNumber];
    }
    
    for (NSString *word in array3) {
        for (int i=0; i<wordLength; i++) {
            [wordlettersArray replaceObjectAtIndex:i withObject:@""];
        }
        for (int i=0; i<wordLength; i++) {
            if ([guessedLettersArray containsObject:[word substringWithRange: NSMakeRange(i,1)]]) {
                [wordlettersArray replaceObjectAtIndex:i withObject:[word substringWithRange: NSMakeRange(i,1)]];
            }
        }
        if ([guessedLettersArray isEqualToArray:wordlettersArray]) {
            [array6 addObject:word];
        }
    }
    
    if ([array6 count] != 0) {
        array3 = array6;
    }
    
    for (NSString *word in array3) {
        if ([word rangeOfString:fieldLetter].location == NSNotFound) {
            [array4 addObject:word];
        }
        else if([word rangeOfString:fieldLetter].location != NSNotFound) {
            [array5 addObject:word];
        }
    }

    if ([array4 count] >= [array5 count]) {
        array2 = array4;
    }
    else {
        array2 = array5;
    }
    
    for (NSString *word in array2) {
        for (int i=0; i<wordLength; i++) {
            if ([fieldLetter isEqualToString: [word substringWithRange: NSMakeRange(i,1)]]) {
                NSString *nString = [array7 objectAtIndex:i];
                int nInt = [nString intValue];
                nInt++;
                nString = [NSString stringWithFormat:@"%d",nInt];
                [array7 replaceObjectAtIndex:i withObject:nString];
            }
        }
    }
    NSNumber *maxNum = [array7 valueForKeyPath:@"@max.intValue"];
    NSString *number = [[NSString alloc] initWithFormat:@"%@", maxNum];
    int index = [array7 indexOfObject:number];
    
    if (index != 2147483647) {
        for (NSString *word in array2) {
            // de i-de letter in het woord moet gelijk zijn aan fieldLetter
            if ([fieldLetter isEqualToString: [word substringWithRange: NSMakeRange(index,1)]]) {
                [array8 addObject:word];
            }
        }
    }
    else {
        array8 = array2;
    }
    array2 = array8;
    
    
    // Stop alle woorden in array8 die fieldLetter op de hoogste plaats van Array 7 hebben staan
    
    

    // Pick a random word from the array
    NSInteger *randomIndex = arc4random() % [array2 count];
    NSString *word = [array2 objectAtIndex:randomIndex];
    return word;
}

- (NSString *)checkWord {
    if (word == @"") {
        word = [self chooseNormalWord];
        return word;
    }
    else {
        return word;
    }
    
}
- (IBAction)change:(id)sender {
    if (gameEnd != true) {
        
        if (evilGame == true) {
            word = [self chooseEvilWord];
        }
        else if (evilGame == false) {
            word = [self checkWord];
        }
        
        int fieldLength = [inputField.text length];
        NSString *fieldLetter = @"";
        fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
        
        if ([[fieldLetter stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]] isEqualToString:@""]) {
                    
            bool correctLetterCheck = false;
            
            for (int i=0; i<wordLength; i++) {
                NSString *wordLetter = [word substringWithRange:NSMakeRange(i, 1)];
                    
                // If current letter is equal to this particular letter
                if ([fieldLetter isEqualToString:(wordLetter)]) {
                    if ([goodLetters rangeOfString:fieldLetter].location == NSNotFound) {
                        fieldLettersSolved++;
                        goodTries++;
                        
                        tempGoodLetters = [NSString stringWithFormat:@"%@%@", goodLetters, fieldLetter];
                    }
                    correctLetterCheck = true;
                    [guessedLettersArray replaceObjectAtIndex:i withObject:wordLetter];
                }
            }
            goodLetters = tempGoodLetters;
            
            int i = 0;
            for (NSString *guessedLetter in guessedLettersArray) {
                [[self.lettersArray objectAtIndex:i] setTitle:guessedLetter forState:(UIControlStateNormal)];
                i++;
            }
            
            if (correctLetterCheck == false) {
                // Check if pressed letter has already been pressed
                if ([badLetters rangeOfString:fieldLetter].location == NSNotFound) {
                    badTries++;
                    badLetters = [NSString stringWithFormat:@"%@%@", badLetters, fieldLetter];
                }
                // Display next image
                for (int i=1; i<=6; i++) {
                    if (badTries - (endTries - 6) == i) {
                        NSString *hangmanImageName = [NSString stringWithFormat:@"%d.png", i + 1];
                        UIImage *hangmanImageNow = [UIImage imageNamed:hangmanImageName];
                        [hangmanImage setImage:hangmanImageNow];
                    }
                }
            }
                    
            // If everything is solved
            if (![guessedLettersArray containsObject:@""]) {
                // Show Alert (win)
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:    @"You won!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                gameEnd = true;
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
                gameEnd = true;
            }
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
    array2 = [[NSDictionary alloc] init];
    for (int i=0; i<wordLength; i++) {
        [guessedLettersArray replaceObjectAtIndex:i withObject:@""];
    }
    
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    array2 = [dictionary valueForKey:@"array"];
    
    // Reset string variables
    goodLetters = @"";
    badLetters = @"";
    
    // Reset word
    word = @"";
    
    // Display basic image
    UIImage *hangmanImageNow = [UIImage imageNamed:@"1.png"];
    [hangmanImage setImage:hangmanImageNow];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    guessedLettersArray = [[NSMutableArray alloc] init];
    // test
    for (int i=0; i<wordLength; i++) {
        [guessedLettersArray insertObject:@"" atIndex:i];
    }
    
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    array2 = [dictionary valueForKey:@"array"];
    
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
