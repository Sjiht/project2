//
//  ELLNormalGame.m
//  project2-4
//
//  Created by Patrick de Koning on 5/22/14.
//  Copyright (c) 2014 PDKwebs. All rights reserved.
//

#import "ELLNormalGame.h"

@implementation ELLNormalGame

-(NSString *)chooseNormalWord:(NSMutableArray *)wordsArray :(int)wordLength {
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

@end
