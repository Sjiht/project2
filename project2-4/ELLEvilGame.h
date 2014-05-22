//
//  ELLEvilGame.h
//  project2-4
//
//  Created by Patrick de Koning on 5/22/14.
//  Copyright (c) 2014 PDKwebs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELLEvilGame : UIViewController {
    
}

-(NSMutableArray *)chooseEvilWord:(NSMutableArray *)wordsArray :(int)wordLength :(UITextField *)inputField:(NSMutableArray *)guessedLettersArray;
-(NSString *)randomWord:(NSMutableArray *)wordsArray;

@end