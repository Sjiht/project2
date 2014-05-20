//
//  ELLHighscoresController.m
//  project2-4
//
//  Created by Patrick de Koning on 5/7/14.
//  Copyright (c) 2014 PDKwebs. All rights reserved.
//

#import "ELLHighscoresController.h"
#import "ELLHomeController.h"

@implementation ELLHighscoresController {
    NSArray *tableData;
}

- (void)viewDidLoad {
    
    // Set the highscores background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    // Load the userdefaults in the 'score' and put them in tableData
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    tableData = [defaults objectForKey:@"score"];
    
    [super viewDidLoad];
    
    // Sort the scores descending
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"points" ascending: NO];
    tableData = [tableData sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Make the table
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Make the cellData from the tableData
    NSMutableDictionary *cellData = [tableData objectAtIndex:indexPath.row];
    
    // Format the text that should be displayed in the cell
    NSString *cellText = [NSString stringWithFormat:@"%@                   %@",[cellData objectForKey:@"points"],[cellData objectForKey:@"date"]];
    
    // Add an extra space if the score is 3 digits (200 instead of 2000)
    if ([cellText length] < 33) {
        cellText = [NSString stringWithFormat:@"  %@",cellText];
    }
    
    // Set the text as celltext
    cell.textLabel.text = cellText;
    
    // Check which difficulty the score was played on to display an evil or a normal image
    NSString *difficultyString = [cellData objectForKey:@"evil"];
    int difficultyInt = difficultyString.intValue;
    if (difficultyInt == 1) {
        cell.imageView.image = [UIImage imageNamed:@"evil.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"normal.png"];
    }
    
    return cell;
}

- (IBAction)resetHighscores:(id)sender {
    // Load the userdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Remove all objects in the highscores
    NSDictionary *dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    
    // Load the highscores view
    ELLHighscoresController *highscoresController = [[ELLHighscoresController alloc] initWithNibName:@"Highscores" bundle:nil];
    [self presentViewController:highscoresController animated:NO completion:nil];
}

- (IBAction)menu:(id)sender {
    // Menu button to go back to the menu view
    ELLHomeController *menuController = [[ELLHomeController alloc] initWithNibName:@"Home" bundle:nil];
    
    [self presentViewController:menuController animated:NO completion:nil];
}

@end