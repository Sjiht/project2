//
//  ELLViewController.m
//  project2-4
//
//  Created by Patrick de Koning on 6/2/12.
//  Copyright (c) 2012 PDKwebs. All rights reserved.
//

#import "ELLViewController.h"
#import "ELLHomeController.h"

@implementation ELLViewController
@synthesize lettersArray;
@synthesize evilGame;
@synthesize wordLength;
@synthesize endTries;

// Create integer variables
int fieldLettersSolved;
int goodTries;
int badTries;

// Create Mutable arrays
NSMutableArray *wordLetterArray;
NSMutableArray *guessedLettersArray;
NSMutableArray *wordsArray;
NSMutableArray *lowerCasedArray;

// Create empty string variables
NSString *tempGoodLetters = @"";
NSString *goodLetters = @"";
NSString *badLetters = @"";
NSString *word = @"";

// Create booleans
bool gameEnd;

- (NSString *)chooseNormalWord {
    // Lowercase all the words
    NSMutableArray *lowerCasedArray = [[NSMutableArray alloc] init];
    for (NSString *key in wordsArray) {
        NSString *keyLowercase = [key lowercaseString];
        int length = [key length];
        if (length == wordLength) {
            [lowerCasedArray addObject:keyLowercase];
        }
    }
    
    // Pick a random word from the lower cased wordlist
    NSInteger randomIndex = arc4random() % [lowerCasedArray count];
    NSString *word = [lowerCasedArray objectAtIndex:randomIndex];
    return word;
    NSLog(@"%@", word);
}

- (NSString *)chooseEvilWord {
    NSMutableArray *lowerCasedArray = [[NSMutableArray alloc] init];
    for (NSString *key in wordsArray) {
        NSString *keyLowercase = [key lowercaseString];
        int length = [key length];
        if (length == wordLength) {
            [lowerCasedArray addObject:keyLowercase];
        }
    }
    
    // Get the user input
    int fieldLength = [inputField.text length];
    NSString *fieldLetter = @"";
    fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
    
    // Define arrays for the algorithm
    NSMutableArray *subSet1 = [[NSMutableArray alloc] init];
    NSMutableArray *subSet2 = [[NSMutableArray alloc] init];
    NSMutableArray *mainSet = [[NSMutableArray alloc] init];
    NSMutableArray *letterPositionArray = [[NSMutableArray alloc] init];
    NSMutableArray *letterArray = [[NSMutableArray alloc] init];
    NSMutableArray *wordlettersArray = [[NSMutableArray alloc] init];
    
    // Fill the letter-array with placeholders 
    for (int i=0; i<wordLength; i++) {
        [wordlettersArray insertObject:@"" atIndex:i];
    }
    
    // Fill the letterposition-array with placeholders
    NSNumber *someNumber = [NSNumber numberWithInt:0];
    for (int i=0; i<wordLength; i++) {
        [letterPositionArray addObject:someNumber];
    }
    
    // Loop through all the words
    for (NSString *word in lowerCasedArray) {
        // Patrick wat doen we hier? dit gebeurt toch ook al hierboven?
        for (int i=0; i<wordLength; i++) {
            [wordlettersArray replaceObjectAtIndex:i withObject:@""];
        }
        // If the user has guessed a correct letter put the letter at the correct position(s)
        for (int i=0; i<wordLength; i++) {
            if ([guessedLettersArray containsObject:[word substringWithRange: NSMakeRange(i,1)]]) {
                [wordlettersArray replaceObjectAtIndex:i withObject:[word substringWithRange: NSMakeRange(i,1)]];
            }
        }
        if ([guessedLettersArray isEqualToArray:wordlettersArray]) {
            [mainSet addObject:word];
        }
    }
    
    if ([mainSet count] != 0) {
        lowerCasedArray = mainSet;
    }
    
    for (NSString *word in lowerCasedArray) {
        if ([word rangeOfString:fieldLetter].location == NSNotFound) {
            [subSet1 addObject:word];
        }
        else if([word rangeOfString:fieldLetter].location != NSNotFound) {
            [subSet2 addObject:word];
        }
    }

    // Check which subset is bigger and then make that the main set
    if ([subSet1 count] >= [subSet2 count]) {
        wordsArray = subSet1;
    }
    else {
        wordsArray = subSet2;
    }
    
    for (NSString *word in wordsArray) {
        for (int i=0; i<wordLength; i++) {
            if ([fieldLetter isEqualToString: [word substringWithRange: NSMakeRange(i,1)]]) {
                NSString *nString = [letterPositionArray objectAtIndex:i];
                int nInt = [nString intValue];
                nInt++;
                nString = [NSString stringWithFormat:@"%d",nInt];
                [letterPositionArray replaceObjectAtIndex:i withObject:nString];
            }
        }
    }
    NSNumber *maxNum = [letterPositionArray valueForKeyPath:@"@max.intValue"];
    NSString *number = [[NSString alloc] initWithFormat:@"%@", maxNum];
    int index = [letterPositionArray indexOfObject:number];
    
    if (index != 2147483647) {
        for (NSString *word in wordsArray) {
            // de i-de letter in het woord moet gelijk zijn aan fieldLetter
            if ([fieldLetter isEqualToString: [word substringWithRange: NSMakeRange(index,1)]]) {
                [letterArray addObject:word];
            }
        }
    }
    else {
        letterArray = wordsArray;
    }
    wordsArray = letterArray;
    
    
    // Stop alle woorden in letterArray die fieldLetter op de hoogste plaats van Array 7 hebben staan
    
    

    // Pick a random word from the array
    NSInteger randomIndex = arc4random() % [wordsArray count];
    NSString *word = [wordsArray objectAtIndex:randomIndex];
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

- (IBAction)menu:(id)sender {
    ELLHomeController *menuController = [[ELLHomeController alloc] initWithNibName:@"Home" bundle:nil];
        
    [self presentViewController:menuController animated:NO completion:nil];
}
- (IBAction)change:(id)sender {
    if (gameEnd != true) {
        
        if (self.evilGame == true) {
            word = [self chooseEvilWord];
        }
        else {
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
                gameEnd = true;
                
                int scoreInt = (int)(((float)wordLength / (float)endTries) * 1200 + ((endTries - badTries) * 50));
                if (evilGame == true) {
                    scoreInt = scoreInt * 2.5;
                }
                
                NSString *difficulty;
                if (evilGame == true) {
                    difficulty = @"1";
                }
                else {
                    difficulty = @"0";
                }
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"dd-MM-yyyy"];
                NSString *myDate = [df stringFromDate:[NSDate date ]];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSArray *oldScoreArray = [defaults objectForKey:@"score"];
                NSMutableArray *newScoreArray = [NSMutableArray arrayWithArray:oldScoreArray];
                NSMutableDictionary *testDictionary = [[NSMutableDictionary alloc] init];
                
                NSNumber *pointsNumber = [NSNumber numberWithInt:scoreInt];
                [testDictionary setObject:pointsNumber forKey:@"points"];
                [testDictionary setObject:myDate forKey:@"date"];
                [testDictionary setObject:difficulty forKey:@"evil"];
                
                NSMutableDictionary *md = [testDictionary mutableCopy];
                
                [newScoreArray addObject:md];
                
                [defaults setObject:newScoreArray forKey:@"score"];
                
                [defaults synchronize];
                
                NSString *winText = [NSString stringWithFormat:@"You won! Your score is %d", scoreInt];
                
                // Show Alert (win)
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:    winText delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];            }
            
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
    wordsArray = [[NSMutableArray alloc] init];
    for (int i=0; i<wordLength; i++) {
        [guessedLettersArray replaceObjectAtIndex:i withObject:@""];
    }
    
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    wordsArray = [dictionary valueForKey:@"array"];
    
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
    
    if (evilGame == true) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-evil.png"]];
        triesLabel.textColor = [UIColor whiteColor];
        badLettersLabel.textColor = [UIColor whiteColor];
        triesTextLabel.textColor = [UIColor whiteColor];
        badLettersTextLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-normal.png"]];
    }
    
    guessedLettersArray = [[NSMutableArray alloc] init];
    // test
    for (int i=0; i<wordLength; i++) {
        [guessedLettersArray insertObject:@"" atIndex:i];
    }
    
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    wordsArray = [dictionary valueForKey:@"array"];
    
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
    
    [self newgame:nil];
}

- (void)viewDidUnload
{
    menuButton = nil;
    badLettersTextLabel = nil;
    triesTextLabel = nil;
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
