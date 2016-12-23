//
//  ViewController.m
//  APPRomulo
//
//  Created by Denis Nascimento on 12/21/12.
//  Copyright (c) 2012 THS Solution Ltda. All rights reserved.
//

#import "ViewController.h"
#import "FliteTTS.h"
#import "DBHandler.h"
#import <AVFoundation/AVFoundation.h>
#import "Reachability.h"

#define TAG_SHEFT 74257


@class FliteTTS;

@interface ViewController ()<AVAudioPlayerDelegate,UITableViewDataSource,UITableViewDelegate>{
 
    FliteTTS *fliteEngine;
    AVAudioPlayer *audioPlayer;
    AVPlayer* player;

    
}
@property (nonatomic, strong) AVAudioPlayer *thisPlayer;
@property (nonatomic,retain) NSArray *items;

@end;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    fliteEngine = [[FliteTTS alloc] init];
    [fliteEngine setPitch:125.0 variance:11.0 speed:1.1];
    
    [self.viewABC setTag:TAG_SHEFT+1];
    [self.view123 setTag:TAG_SHEFT+2];
    [self.viewPRE setTag:TAG_SHEFT+3];
    [self.tableview setBackgroundColor:[UIColor clearColor]];
    
//    for (UIView *view in self.btnABC.subviews) {
//        if ([view isKindOfClass:[UILabel class]]) {
//            UILabel *label = (UILabel*)view;
//            [label setFrame:CGRectMake(0, 0, self.btnABC.frame.size.width, self.btnABC.frame.size.height)];
//        }
//    }
    
//   self.btnABC.titleLabel = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSpeechMessage:(id)sender {

    [self speechText:self.messageText.text];
    
    if (self.messageText.text.length > 2) {
        [self insertWord:self.messageText.text];        
    }


}


-(IBAction)typeLetterInLabel:(UIButton*)button{
//    
//    if ([self.messageToSpeech.text isEqualToString:@"Digite"]) {
//        self.messageToSpeech.text = @"";
//    }
    
    NSString *speech_ = NULL;
    
    NSString *word = [NSString stringWithFormat:@"%@%@",self.messageText.text,button.titleLabel.text];
    NSString *letter = button.titleLabel.text;
   // self.messageToSpeech.text =word;
    self.messageText.text = word;

  [self speechText:letter];
  return;
    
    @try
  {

      if ([letter isEqualToString:@"."])
        {
            speech_ = @"ponto";
        }
        else
        {
            speech_ = letter;
        }
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:speech_ ofType:@"mp3"];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:NULL];
        [audioPlayer prepareToPlay];
        [audioPlayer play];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
        
}

-(IBAction)goArrowBack:(UIButton*)sender{
    
    NSLog(@"goArrowBack");
    
}

-(IBAction)goArrowNext:(UIButton*)sender{
 
    NSLog(@"goArrowNext");
}


-(IBAction)goBackSpace:(UIButton*)sender{
    
    NSLog(@"goBackSpace");
     NSString *word = [NSString stringWithFormat:@"%@%@",self.messageText.text,@" "];
    self.messageText.text = word;
    [self speechText:@"backspace"];
  return;
    
    @try {
               
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"espasso" ofType:@"mp3"];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:NULL];
        [audioPlayer prepareToPlay];
        [audioPlayer play];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    
}


-(IBAction)goDelete:(UIButton*)sender{
    
    NSLog(@"goDelete");
    
    if (self.messageText.text.length > 0) {
        NSString *value = [self.messageText.text substringToIndex:[self.messageText.text length] - 1];
        self.messageText.text = value;
        [self speechText:@"delete"];
      return;
        
        @try {
            
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"apagar" ofType:@"mp3"];
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:NULL];
            [audioPlayer prepareToPlay];
            [audioPlayer play];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }

}

-(void)speekWeb:(NSString*)text{
    
    //NSString *urlString = [NSString stringWithFormat:@"http://www.translate.google.com/translate_tts?tl=en&prev=input&q=%@",[text lowercaseString]];
  NSString *urlString = [NSString stringWithFormat:@"https://translate.google.com/translate_tts?ie=UTF-8&q=%@&tl=PT&client=tw-ob",[text lowercaseString]];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *path = [[Constants libraryCacheFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",text]];
    
    [data writeToFile:path atomically:YES];
    
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:path] options:nil];
    AVPlayerItem *anItem = [AVPlayerItem playerItemWithAsset:asset];

    
    player = [AVPlayer playerWithPlayerItem:anItem];
    [player addObserver:self forKeyPath:@"status" options:0 context:nil];
    [player play];
    

    
}

-(void)speekLocal:(NSString*)text{
  [fliteEngine speakText:text];  
}


-(void)speechText:(NSString*)text{

    //NSString *soundPath = [[NSBundle mainBundle] pathForResource:text ofType:@"mp3"];
    NSString *path = [[Constants libraryCacheFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",text]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:path]) {

        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        [audioPlayer prepareToPlay];
        [audioPlayer play];

    }
    else
    {
        
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        switch ([reachability currentReachabilityStatus])
        {
            case NotReachable :
                [self speekLocal:text];
            case kReachableViaWiFi :
                [self speekWeb:text];
             default : break;
        }
    
   }


}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == player && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
        } else if (player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayer Ready to Play");
        } else if (player.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}



- (IBAction)goABC:(id)sender {
    
    [self animateViewWithViewShow:self.viewABC];
    
}

- (IBAction)goPRE:(id)sender {
    [self updateTableView];
    [self animateViewWithViewShow:self.viewPRE];

}

- (IBAction)goConfig:(id)sender {
}

- (IBAction)go123:(id)sender {
    
    [self animateViewWithViewShow:self.view123];
}


-(void)animateViewWithViewShow:(UIView*)viewShow{
    
    
     // NSLog(@"sheftViewNow:%@",viewShow);

    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         for (UIView *view in self.view.subviews) {
                             
                             for (int i= 1; i <= 3; i++) {
                                 
                                 if (view.tag == TAG_SHEFT+i) {
                                     [view setAlpha:0];
                                      NSLog(@"view:%@",view);
                                 }
                                 
                             }
                             
                         }
                         
                     }
                     completion:^(BOOL finished){
                         [viewShow setHidden:NO];
                         [viewShow setAlpha:0];
                         
                         if (viewShow == self.viewPRE) {
                             [self.btnSpeek setHidden:YES];
                         }else{
                             [self.btnSpeek setHidden:NO];
                         }
                         
                         [UIView animateWithDuration:0.5
                                          animations:^{
                              [viewShow setAlpha:1];
                                                                                    }
                               completion:^(BOOL finished){
                                   
                                   
                                }];
                         
                     }];
    
}


- (void)viewDidUnload {
    [self setTableview:nil];
    [self setViewPRE:nil];
    [self setBtnSpeek:nil];
    [self setMessageText:nil];
    [self setBtnABC:nil];
    [super viewDidUnload];
}

-(void)updateTableView{
    
    self.items = [self getAllWordsInDatabase];
    [self.tableview reloadData];
}


#pragma -
#pragma Methods of TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  NSString *cellIdentifield = @"cellHome";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifield];
  if (cell == nil)
  {

    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifield];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:90];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];

    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.backgroundColor = [UIColor clearColor];

  }
  cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
  
  return cell;
  
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self speechText:[self.items objectAtIndex:indexPath.row]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSLog(@"CountTotal:%d",[self.items  count]);
    return [self.items  count];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteWord:[self.items objectAtIndex:indexPath.row]];
        [self updateTableView];
        
    }
  
}

-(NSArray*)getAllWordsInDatabase{
    
    
    NSString *sql = [NSString stringWithFormat:@"SELECT id, word from words order by 1 desc "];
    NSMutableArray *arrayTmp = [NSMutableArray array];
    
    sqlite3_stmt *consult = [[DBHandler shared]runSQL:sql];
    
    while (sqlite3_step(consult)==SQLITE_ROW)
    {
        [arrayTmp addObject:[DBHandler cStringToOBJC:(const char *)sqlite3_column_text(consult, 1)]];
    }
    
    return (NSArray*)arrayTmp;

    
}

-(BOOL)insertWord:(NSString*)word{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO words (word) values ('%@')",word];
                        
    if ([self hasTitlesWithContentId:[word uppercaseString]]) {
        
        return NO;
    }else{
        
        if ([[DBHandler shared]runSQL:sql])
            return YES;
    }

    return NO;

    
}

-(void)deleteWord:(NSString*)word{
    
    NSString *sql = [NSString stringWithFormat:@"delete from words where word = '%@' ",word];
    [[DBHandler shared]runSQL:sql];
}


- (BOOL)hasTitlesWithContentId:(NSString*)word {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT word FROM words WHERE upper(word) = '%@' ",word];
    
    sqlite3_stmt *consulta = [[DBHandler shared]runSQL:sql];
    
    if (sqlite3_step(consulta) == SQLITE_ROW) {
        sqlite3_finalize(consulta);
        return YES;
    }
    sqlite3_finalize(consulta);
    return NO;
    
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return NO;
 
}



@end
