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
int endTries = 6;
int wordLength = 3;

// Create Mutable arrays
NSMutableArray *wordLetterArray;

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

- (NSString *)chooseEvilWord {
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
    
    // uek
    // iuk
    // iok
    // dfk
    // ydk
    // ejf
    // aaa
    // abc
    // abd
    
    // eerst de woorden pakken waar de letters op de juiste plek zitten die al getypt zijn.
    
    // array maken die bestaat uit x elementen. x is het aantal letters van het woord.
    // als een letter op die plek hoort, zet hem in de array op de juiste plek (bijvoorbeeld 3).
    // array3 als eerste alleen de letters woorden pakken die de letters al op de juiste plek hebben
    
    // 1. geval typt "A". kijk of groep met A in woord groter is dan groep met A niet in woord. zo ja: neem die groep. zo nee, neem de groep zonder A. In geval even groot, neem zonder A.
    
    int fieldLength = [inputField.text length];
    NSString *fieldLetter = @"";
    fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
    
    NSMutableArray *array4 = [[NSMutableArray alloc] init];
    NSMutableArray *array5 = [[NSMutableArray alloc] init];
    NSArray *array6 = [[NSArray alloc] init];
    
    for (NSString *word in array3) {
        if ([word rangeOfString:fieldLetter].location == NSNotFound) {
            [array4 addObject:word];
        }
        else if([word rangeOfString:fieldLetter].location != NSNotFound) {
            [array5 addObject:word];
        }
    }
    
    if ([array4 count] >= [array5 count]) {
        array6 = array4;
    }
    else {
        array6 = array5;
    }
    
    // Pick a random word from the array
    NSInteger *randomIndex = arc4random() % [array6 count];
    NSString *word = [array6 objectAtIndex:randomIndex];
    NSLog(word);
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
        
        bool correctLetterCheck = false;
        
        for (int i=0; i<wordLength; i++) {
            NSString *wordLetter = [word substringWithRange:NSMakeRange(i, 1)];
                
            // If current letter is equal to this particular letter
            if ([fieldLetter isEqualToString:(wordLetter)]) {
                if ([goodLetters rangeOfString:fieldLetter].location == NSNotFound) {
                    [[self.lettersArray objectAtIndex:i] setTitle:fieldLetter forState:(UIControlStateNormal)];
                    fieldLettersSolved++;
                    goodTries++;
                    
                    tempGoodLetters = [NSString stringWithFormat:@"%@%@", goodLetters, fieldLetter];
                    //goodLetters = [NSString stringWithFormat:@"%@%@", goodLetters, fieldLetter];
                }
                correctLetterCheck = true;
            }
        }
        goodLetters = tempGoodLetters;
        
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
    goodLetters = @"";
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
