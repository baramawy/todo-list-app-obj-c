//
//  DetailsViewController.m
//  ToDoListAppWorkShop
//
//  Created by Mostafa Baramawy on 13/08/2024.
//

#import "DetailsViewController.h"
#import "Notes.h"
#import "ViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmantPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmantType;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDescription;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (nonatomic, strong) Notes *currentNote;
- (BOOL)isValidTextFields;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.currentNote) {
        self.textFieldTitle.text = self.currentNote.title;
        self.textFieldDescription.text = self.currentNote.description;
        self.segmantPriority.selectedSegmentIndex = self.currentNote.priority;
        self.segmantType.selectedSegmentIndex = self.currentNote.type;
        self.datePicker.date = self.currentNote.date;
        
        // Do any additional setup after loading the view.
    }
}
- (IBAction)addNotes:(id)sender {
    if ([self isValidTextFields]) {
        // Update or create new note
        if (self.currentNote) {
            self.currentNote.title = self.textFieldTitle.text;
            self.currentNote.description = self.textFieldDescription.text;
            self.currentNote.priority = self.segmantPriority.selectedSegmentIndex;
            self.currentNote.type = self.segmantType.selectedSegmentIndex;
            self.currentNote.date = self.datePicker.date;
        } else {
            self.currentNote = [Notes new];
            self.textFieldTitle.text = self.currentNote.title;
            self.textFieldDescription.text = self.currentNote.title;
            self.segmantPriority.selectedSegmentIndex = self.currentNote.priority;
            self.segmantType.selectedSegmentIndex = self.currentNote.type;
            self.datePicker.date = self.currentNote.date;
            
        }
//        // Save to UserDefaults
//        [self saveNoteToDefaults:self.currentNote];
//        
//        // Confirm and dismiss
//        [self showConfirmationAlert];
    }
//    else {
//        [self showInvalidInputAlert];
//    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (BOOL)isValidTextFields {
    if (_textFieldTitle.text.length < 1)
        return FALSE;
    return TRUE;
}

@end
