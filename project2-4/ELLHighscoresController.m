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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    tableData = [defaults objectForKey:@"score"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    [super viewDidLoad];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"points" ascending: NO];
    tableData = [tableData sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSMutableDictionary *cellData = [tableData objectAtIndex:indexPath.row];
    
    NSString *cellText = [NSString stringWithFormat:@"%@                   %@",[cellData objectForKey:@"points"],[cellData objectForKey:@"date"]];
    
    if ([cellText length] < 33) {
        cellText = [NSString stringWithFormat:@"  %@",cellText];
    }
    cell.textLabel.text = cellText;
    
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    
    ELLHighscoresController *highscoresController = [[ELLHighscoresController alloc] initWithNibName:@"Highscores" bundle:nil];
    [self presentViewController:highscoresController animated:NO completion:nil];
}

- (IBAction)menu:(id)sender {
    ELLHomeController *menuController = [[ELLHomeController alloc] initWithNibName:@"Home" bundle:nil];
    
    [self presentViewController:menuController animated:NO completion:nil];
}

@end