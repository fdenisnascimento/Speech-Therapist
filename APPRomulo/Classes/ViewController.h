//
//  ViewController.h
//  APPRomulo
//
//  Created by Denis Nascimento on 12/21/12.
//  Copyright (c) 2012 THS Solution Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)btnSpeechMessage:(id)sender;
- (IBAction)goABC:(id)sender;
- (IBAction)goPRE:(id)sender;
- (IBAction)goConfig:(id)sender;
- (IBAction)go123:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewABC;
@property (weak, nonatomic) IBOutlet UIView *view123;
@property (weak, nonatomic) IBOutlet UIView *viewPRE;
@property (weak, nonatomic) IBOutlet UILabel *messageToSpeech;
@property (weak, nonatomic) IBOutlet UIButton *btnSpeek;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *messageText;
@property (weak, nonatomic) IBOutlet UIButton *btnABC;

@end
 