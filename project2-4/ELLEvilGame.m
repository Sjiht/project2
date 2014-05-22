//
//  ELLEvilGame.m
//  project2-4
//
//  Created by Patrick de Koning on 5/22/14.
//  Copyright (c) 2014 PDKwebs. All rights reserved.
//

#import "ELLEvilGame.h"

@implementation ELLEvilGame

-(NSMutableArray *)chooseEvilWord:(NSMutableArray *)wordsArray :(int)wordLength :(UITextField *)inputField :(NSMutableArray *)guessedLettersArray {
    // Lowercase all the words
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
    
    // Fill the wordLetter-array with placeholders 
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
    
    // If the mainset is not empty make the primary array the main set
    if ([mainSet count] != 0) {
        lowerCasedArray = mainSet;
    }
    
    // Divide the words into subsets based on the user input
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
    
    
    // Check the letter positions for the word and make sure only words with that letter position are added (for example words with ..a..a )
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
    
    // Get the highest index (for example: 1,3,2,1 it gets 3 so the algorithm picks only words with a letter on the position 3
    NSNumber *maxNum = [letterPositionArray valueForKeyPath:@"@max.intValue"];
    NSString *number = [[NSString alloc] initWithFormat:@"%@", maxNum];
    int index = [letterPositionArray indexOfObject:number];
    
    // Check if the index is found
    if (index != 2147483647) {
        for (NSString *word in wordsArray) {
            // Check if the letter on the position i is the same as the user input an
            if ([fieldLetter isEqualToString: [word substringWithRange: NSMakeRange(index,1)]]) {
                [letterArray addObject:word];
            }
        }
    }
    else {
        letterArray = wordsArray;
    }
    wordsArray = letterArray;
    
    return wordsArray;
}

-(NSString *)randomWord:(NSMutableArray *)wordsArray {
    // Pick a random word from the array
    NSInteger randomIndex = arc4random() % [wordsArray count];
    NSString *word = [wordsArray objectAtIndex:randomIndex];
    return word;
}

@end
