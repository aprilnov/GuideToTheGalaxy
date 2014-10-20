//
//  ViewController.m
//  GuideToTheGalaxy
//
//  Created by April on 14-10-17.
//  Copyright (c) 2014年 April. All rights reserved.
//

#import "ViewController.h"
#import "GGTranslation.h"

@interface ViewController () {
    __weak IBOutlet UITextView *inputTextView;
    __weak IBOutlet UITextView *outputTextView;
}

- (NSString *)getInputContent;
- (void)updateOutputTextView:(NSString *)output;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fileContents = [self getInputContent];
    
    // update input text view
    inputTextView.text = fileContents;
    
    
    NSMutableString *outputStr = [NSMutableString string];
    
    // enumerate lines in input files to generate output
    [fileContents enumerateLinesUsingBlock:^(NSString * line, BOOL * stop) {

        [outputStr appendFormat:@"%@\n", [[GGTranslation sharedInstance] translateInput:line]];
        
        // update output textview in mainthread
        [self performSelector:@selector(updateOutputTextView:) withObject:outputStr afterDelay:0];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (NSString *)getInputContent {
    // read local txt file as input
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"input" ofType:@"txt"];
    
    NSStringEncoding encoding;
    NSError *error;
    NSString *fileContents = [[NSString alloc] initWithContentsOfFile:filePath
                                                         usedEncoding:&encoding
                                                                error:&error];
    
    return fileContents;
}

- (void)updateOutputTextView:(NSString *)output {
    outputTextView.text = output;
}

@end
