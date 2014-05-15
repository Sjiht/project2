//
//  ELLHomeController.h
//  project2-4
//
//  Created by Patrick de Koning on 5/7/14.
//  Copyright (c) 2014 PDKwebs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ELLHomeController : UIViewController {
    // Buttons
    IBOutlet UIButton *newNormalGameButton;
}

@property (weak, nonatomic) IBOutlet UILabel *wordLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *triesLabel;
@property int wordLength;
@property int endTries;

- (IBAction)endTries:(id)sender;
- (IBAction)wordLength:(id)sender;
- (IBAction)newNormalGame:(id)sender;
- (IBAction)newEvilGame:(id)sender;

@end
