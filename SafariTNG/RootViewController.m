//
//  ViewController.m
//  SafariTNG
//
//  Created by Sherrie Jones on 3/11/15.
//  Copyright (c) 2015 Sherrie Jones. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self goToURLString:@"http://www.mobilemakers.co"];
    self.webView.delegate = self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}

// enters new urls in text field
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goToURLString:textField.text];
    return YES;
}

// when url is bad show alert with 2 buttons & stop spinner
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [UIAlertView new];
    alert.delegate = self;  // set the delegate
    alert.title = @"Loading failed! :(";
    alert.message = error.localizedDescription;
    [alert addButtonWithTitle:@"Dismiss"];
    [alert addButtonWithTitle:@"Go Home"];
    [alert show];
    [self.spinner stopAnimating];
}

// when alert "Go Home" is pressed, it returns to mobileMakers
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self goToURLString:@"http://www.mobilemakers.co"];
    }
}

# pragma mark - Helper methods

- (void)goToURLString:(NSString *)string {
    NSString *urlString = string;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}





@end
