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
    ELLNormalGame *normalGameController = [[ELLNormalGame alloc] init];
    return [normalGameController chooseNormalWord:wordsArray :wordLength];
    
}

- (NSString *)chooseEvilWord {
    ELLEvilGame *evilGameController = [[ELLEvilGame alloc] init];
    wordsArray = [evilGameController chooseEvilWord:wordsArray :wordLength :inputField :guessedLettersArray];
    
    return [evilGameController randomWord:wordsArray];
}

- (NSString *)checkWord {
    // Check if a word is not defined and choose a new word, else keep the current word
    if (word == @"") {
        word = [self chooseNormalWord];
        return word;
    }
    else {
        return word;
    }
    
}

- (IBAction)menu:(id)sender {
    // Menu button to go back to the home view
    ELLHomeController *menuController = [[ELLHomeController alloc] initWithNibName:@"Home" bundle:nil];
        
    [self presentViewController:menuController animated:NO completion:nil];
}
- (IBAction)change:(id)sender {
    // Check if the game is still in progress
    if (gameEnd != true) {
        
        // Check if the users wants the evil mode or the normal mode
        if (self.evilGame == true) {
            word = [self chooseEvilWord];
        }
        else {
            word = [self checkWord];
        }
        
        // Get the user input 
        int fieldLength = [inputField.text length];
        NSString *fieldLetter = @"";
        fieldLetter = [inputField.text substringWithRange:NSMakeRange(fieldLength-1, 1)];
        
        // Check if the user input is a letter
        if ([[fieldLetter stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]] isEqualToString:@""]) {
            // Start by saying that the letter is not correct
            bool correctLetterCheck = false;
            
            // Check if the user input is a letter that is the same as a letter in the word
            for (int i=0; i<wordLength; i++) {
                NSString *wordLetter = [word substringWithRange:NSMakeRange(i, 1)];
                    
                // If current letter is equal to this particular letter in the word
                if ([fieldLetter isEqualToString:(wordLetter)]) {
                    if ([goodLetters rangeOfString:fieldLetter].location == NSNotFound) {
                        fieldLettersSolved++;
                        goodTries++;
                        
                        // Add the letter to the list of good letters
                        tempGoodLetters = [NSString stringWithFormat:@"%@%@", goodLetters, fieldLetter];
                    }
                    // The user has provided a correct letter
                    correctLetterCheck = true;
                    [guessedLettersArray replaceObjectAtIndex:i withObject:wordLetter];
                }
            }
            goodLetters = tempGoodLetters;
            
            int i = 0;
            // Update the buttons with the guessed letters
            for (NSString *guessedLetter in guessedLettersArray) {
                [[self.lettersArray objectAtIndex:i] setTitle:guessedLetter forState:(UIControlStateNormal)];
                i++;
            }
            
            // If the user has provided a wrong letter
            if (correctLetterCheck == false) {
                // Check if pressed letter has already been pressed
                if ([badLetters rangeOfString:fieldLetter].location == NSNotFound) {
                    badTries++;
                    badLetters = [NSString stringWithFormat:@"%@%@", badLetters, fieldLetter];
                }
                // Display next image, starting if the user has 6 guesses left
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
                
                // Calculate the score
                int scoreInt = (int)(((float)wordLength / (float)endTries) * 1200 + ((endTries - badTries) * 50));
                if (evilGame == true) {
                    scoreInt = scoreInt * 2.5;
                }
                
                // Format the difficulty to insert with the score
                NSString *difficulty;
                if (evilGame == true) {
                    difficulty = @"1";
                }
                else {
                    difficulty = @"0";
                }
                
                // Get the date to insert with the score
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"dd-MM-yyyy"];
                NSString *myDate = [df stringFromDate:[NSDate date ]];
                
                // Get the NSUserDefaults
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                // Get the previous highscores
                NSArray *oldScoreArray = [defaults objectForKey:@"score"];
                
                // Combine the previous highscores with the array that will contain the new highscore
                NSMutableArray *newScoreArray = [NSMutableArray arrayWithArray:oldScoreArray];
               
                // Make a dictionary to insert into the NSUserDefaults
                NSMutableDictionary *testDictionary = [[NSMutableDictionary alloc] init];
                
                // Update the dictionary
                NSNumber *pointsNumber = [NSNumber numberWithInt:scoreInt];
                [testDictionary setObject:pointsNumber forKey:@"points"];
                [testDictionary setObject:myDate forKey:@"date"];
                [testDictionary setObject:difficulty forKey:@"evil"];
                
                // Make a copy to make sure the previous dictionaries in the array are not modified
                NSMutableDictionary *md = [testDictionary mutableCopy];
                
                // Add the dictionary(conatining the highscore) to the array
                [newScoreArray addObject:md];
                
                // Add the array with all the highscores to NSUserDefaults
                [defaults setObject:newScoreArray forKey:@"score"];
                
                [defaults synchronize];
                
                // Make the string that displays when the game is won
                NSString *winText = [NSString stringWithFormat:@"You won! Your score is %d", scoreInt];
                
                // Show the win alert 
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
    
    // Change the background and letter color if the game is evil
    if (evilGame == true) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-evil.png"]];
        triesLabel.textColor = [UIColor whiteColor];
        badLettersLabel.textColor = [UIColor whiteColor];
        triesTextLabel.textColor = [UIColor whiteColor];
        badLettersTextLabel.textColor = [UIColor whiteColor];
    }
    // Else only change the background
    else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-normal.png"]];
    }
    
    guessedLettersArray = [[NSMutableArray alloc] init];
    // Fill the guessed letters array with placeholders
    for (int i=0; i<wordLength; i++) {
        [guessedLettersArray insertObject:@"" atIndex:i];
    }
    
    // Put all the words from the plist in an array
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"plist"]];
    wordsArray = [dictionary valueForKey:@"array"];
    
    // Make the buttons that can hold the letters
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
