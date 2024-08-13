//
//  ViewController.m
//  ToDoListAppWorkShop
//
//  Created by Mostafa Baramawy on 12/08/2024.
//

#import "ViewController.h"
#import "Notes.h"
#import "DetailsViewController.h"
#import "InprogressViewController.h"
#import "DoneViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *toDoTableView;
@property NSMutableArray *arrayOfNotes;
@property NSMutableArray *filteredNotes;
@property BOOL isSearching;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _toDoTableView.delegate = self;
    _toDoTableView.dataSource = self;
    _searchBar.delegate = self;
    _arrayOfNotes = [NSMutableArray new];
    _filteredNotes = [NSMutableArray new];
    _isSearching = NO;
    [self retriveUserDefaults];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [self retriveUserDefaults];
}
- (IBAction)addNoteButton:(id)sender {
    DetailsViewController *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [self.navigationController pushViewController:detailsVC animated:true];
}

-(void)retriveUserDefaults{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"notesData"];
    if (data) {
        NSError *error = nil;
        NSArray *notesArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [Notes class], nil] fromData:data error:&error];
        if (error) {
            NSLog(@"Failed to unarchive notes: %@", error.localizedDescription);
        } else {
            self.arrayOfNotes = [notesArray mutableCopy];
        }
    }
    [self.toDoTableView reloadData];
    printf("%lu",(unsigned long)_arrayOfNotes.count);
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Notes *note = self.isSearching ? self.filteredNotes[indexPath.row] : self.arrayOfNotes[indexPath.row];
    
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)note.priority];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.arrayOfNotes removeObjectAtIndex:indexPath.row];
        [self saveNotesToDefaults];
        [self.toDoTableView reloadData];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayOfNotes.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  3;
}
- (void)saveNotesToDefaults {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.arrayOfNotes requiringSecureCoding:NO error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"notesData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isSearching = NO;
        self.filteredNotes = [self.arrayOfNotes mutableCopy];
    } else {
        self.isSearching = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
        self.filteredNotes = [[self.arrayOfNotes filteredArrayUsingPredicate:predicate] mutableCopy];
    }
    [self.toDoTableView reloadData];
}


@end
