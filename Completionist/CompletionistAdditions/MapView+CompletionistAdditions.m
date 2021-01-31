//
//  MapView+CompletionistAdditions.m
//  Go Map!!
//
//  Created by Wolfgang Timme on 31.01.21.
//  Copyright © 2021 Bryce. All rights reserved.
//

#import "MapView+CompletionistAdditions.h"

@interface MapView(ViewModelDelegate) <MapViewModelDelegate>
@end

@implementation MapView (CompletionistAdditions)

- (void)configureViewModel {
    MapViewModel.shared.delegate = self;
}
- (void)presentQuestInterfaceFor:(OsmBaseObject *)baseObject {
    [MapViewModel.shared presentQuestInterfaceFor:baseObject];
}

@end

@implementation MapView (ViewModelDelegate)

- (void)askMultipleChoiceQuestionWithQuestion:(NSString *)question
                                      choices:(NSArray<NSString *> *)choices
                             selectionHandler:(void (^)(NSInteger))selectionHandler {
    UIAlertControllerStyle alertStyle = UIAlertControllerStyleActionSheet;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        alertStyle = UIAlertControllerStyleAlert;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:question
                                                                             message:nil
                                                                      preferredStyle:alertStyle];
    
    [choices enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *choiceAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            selectionHandler(idx);
        }];
        [alertController addAction:choiceAction];
    }];
    
    NSString *cancelActionTitle = NSLocalizedString(@"Cancel",
                                                    @"Title of the button when canceling questions");
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActionTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self.mainViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)askNumericQuestionWithQuestion:(NSString *)question
                                   key:(NSString *)key
                               handler:(void (^)(NSString * _Nullable))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:question
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    __block __weak UITextField *answerTextField;
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        /// Configure the text field for numeric input.
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = key;
        
        /// Keep a reference to the text field so that we can later get the text that the user put in.
        answerTextField = textField;
    }];
    
    NSString *confirmActionTitle = NSLocalizedString(@"Confirm",
                                                     @"Title of the button when finishing the input of numeric quest answers");
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmActionTitle
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
        handler(answerTextField.text);
    }];
    [alertController addAction:confirmAction];
    
    NSString *cancelActionTitle = NSLocalizedString(@"Cancel",
                                                    @"Title of the button when canceling questions");
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActionTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self.mainViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)finishQuestForSelectedObjectByApplyingTagWithKey:(NSString *)key value:(NSString *)value {
    NSMutableDictionary *tags = [NSMutableDictionary dictionary];
    
    if (self.editorLayer.selectedPrimary.tags.count > 0) {
        [tags addEntriesFromDictionary:self.editorLayer.selectedPrimary.tags];
    }
    
    [tags setObject:value forKey:key];
    
    [self setTagsForCurrentObject:tags];
    
    self.editorLayer.selectedNode = nil;
    self.editorLayer.selectedWay = nil;
    self.editorLayer.selectedRelation = nil;
    
    [self removePin];
}



@end
