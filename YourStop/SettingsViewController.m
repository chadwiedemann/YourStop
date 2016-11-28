//
//  SettingsViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/15/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SettingsViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

{
    NSMutableArray *pickerDistanceArray;
    NSMutableArray *fractionNumberArray;
    NSMutableArray *pickerRingToneArray;
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hello here is data %f",self.editingDestination.coordinate.latitude);
    
    //
    self.txfLocationName.delegate = self;
    
    //keyboard dissapears when screen is tapped
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    
    // Set up the navigation bar
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveSettings)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Set up the distance picker view
    pickerDistanceArray = [[NSMutableArray alloc]init];
    fractionNumberArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 11; i++) {
        NSString *wholeNumber = [NSString stringWithFormat:@"%d", i];
        [pickerDistanceArray addObject:wholeNumber];
        
    }
    
    for (int j = 0; j < 10; j++) {
        NSString *fractionNumber = [NSString stringWithFormat:@"%d", j];
        [fractionNumberArray addObject:fractionNumber];
        
    }
    
    // Set up ring tone picker view
    pickerRingToneArray = [[NSMutableArray alloc]init];
    [pickerRingToneArray addObject:@"AfricanFunLong"];
    [pickerRingToneArray addObject:@"Techological"];
    [pickerRingToneArray addObject:@"MrJasonJazz"];
    [pickerRingToneArray addObject:@"HouseParty"];
    
    
    // Set the border for the picker view
    self.pickerViewDistance.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.pickerViewDistance.layer.borderWidth = 2;
    
    self.pickerViewRingTone.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.pickerViewRingTone.layer.borderWidth = 2;
    
    // Set up the switch display
    if (self.switchVibration.isOn) {
        self.lblVibrationStatus.text = @"Vibration is ON";
    } else {
        self.lblVibrationStatus.text = @"Vibration is OFF";
    }
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.editingDestination.ringTone = @"AfricanFunLong.mp3";
}

#pragma mark - UIPicker view

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger number = 0;
    if (pickerView == _pickerViewDistance) {
    return 4;
    }
    else if (pickerView == _pickerViewRingTone) {
        return 1;
    }
    
    return number;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    NSInteger number = 0;
    if (pickerView == _pickerViewDistance) {
    NSInteger result = 0;
    switch (component) {
        case 0:
            result  = pickerDistanceArray.count;
            break;
            
        case 1:
            return 1;
            
        case 2:
            result = fractionNumberArray.count;
            break;
            
        case 3:
            result = 1;
            break;
            
        default:
            break;
    }
    
    return result;
    }
    
    else if (pickerView == _pickerViewRingTone) {
        return pickerRingToneArray.count;
    }
    
    return number;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (pickerView == _pickerViewDistance) {
    switch (component)
    {
        case 0:
            return 30.0f;
        case 1:
            return 20.0f;
        case 2:
            return 30.0f;
        case 3:
            return 90.0f;
    }
    return 0;
    }
    
    else if (pickerView == _pickerViewRingTone) {
        return 200.0f;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    
    if (pickerView == _pickerViewDistance) {
    NSString *resultString = @"";
    switch (component) {
        case 0:
            resultString = pickerDistanceArray[row];
            break;
            
        case 1:
            resultString = @":";
            break;
            
        case 2:
            resultString = fractionNumberArray[row];
            break;
            
        case 3:
            resultString = @"Miles";
            break;
            
        default:
            break;
    }
    return resultString;
    }
    
    else if (pickerView == _pickerViewRingTone) {
        return pickerRingToneArray[row];
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == _pickerViewDistance) {
        
    NSString *wholeNumber = @"";
    NSString *fractionNumber = @"";
    
    NSInteger firstComponentRow = [self.pickerViewDistance selectedRowInComponent:0];
    NSInteger thirdComponentRow = [self.pickerViewDistance selectedRowInComponent:2];
    
    switch (firstComponentRow) {
        case 0:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 1:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 2:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 3:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 4:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 5:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 6:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 7:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 8:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 9:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        case 10:
            wholeNumber = pickerDistanceArray[firstComponentRow];
            break;
            
        default:
            break;
    }
    
    switch (thirdComponentRow) {
        case 0:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 1:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 2:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 3:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 4:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 5:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 6:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 7:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 8:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;
            
        case 9:
            fractionNumber = fractionNumberArray[thirdComponentRow];
            break;

            
        default:
            break;
    }
    self.lblDistanceDisplay.text = [NSString stringWithFormat:@"%@.%@ miles from your destination", wholeNumber, fractionNumber];
        double fractionalDistance = [fractionNumber doubleValue] / 10;
        double distance = [wholeNumber doubleValue] + fractionalDistance;
        self.editingDestination.miles = distance;
        
    }
    
    else if (pickerView == _pickerViewRingTone) {
        
        NSString *audioName = pickerRingToneArray[row];
        self.lblRingToneDisplay.text = [NSString stringWithFormat:@"You picked %@ for the alarm", audioName];
        self.editingDestination.ringTone = [NSString stringWithFormat:@"%@.mp3",audioName];
        // Play the audio
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:audioName ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:soundFileURL error:nil];
        [self.audioPlayer setVolume:20];
        [self.audioPlayer play];
        
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    NSString *locationName = self.txfLocationName.text;
//    self.editingDestination.destinationName = locationName;
    [self.txfLocationName resignFirstResponder];
    return YES;
}


-(void)saveSettings
{
    NSString *locationName = self.txfLocationName.text;
    self.editingDestination.destinationName = locationName;
    DAO *dataAccess =  [DAO sharedInstanceOfDAO];
    [dataAccess addDestination:self.editingDestination];
//    [dataAccess.destinationsArray addObject:self.editingDestination];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dismissKeyboard {
    NSString *locationName = self.txfLocationName.text;
    self.editingDestination.destinationName = locationName;
    [self.txfLocationName resignFirstResponder];
}

@end
