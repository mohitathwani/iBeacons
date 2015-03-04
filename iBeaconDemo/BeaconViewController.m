//
//  BeaconViewController.m
//  iBeaconDemo
//
//  Created by Labs on 3/4/15.
//  Copyright (c) 2015 Tera Mo Labs. All rights reserved.
//

#import "BeaconViewController.h"

@interface BeaconViewController ()

@end

@implementation BeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.uuidLabel.text = kUUID;
    self.majorLabel.text = [NSString stringWithFormat:@"%d",kMajor];
    self.minorLabel.text = [NSString stringWithFormat:@"%d",kMinor];
    self.appBundleLabel.text = kBundleID;
    
    [self setupBeacon];
}

- (void) setupBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kUUID];
    NSString *appBundleID = kBundleID;
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:kMajor minor:kMinor identifier:appBundleID];
    
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}

- (IBAction)toggleBeaconState:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) { //iBeacon broadcast is on.
        self.stateLabel.text = @"Tap to turn off";
        
        self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                         queue:nil
                                                                       options:nil];
    }
    
    else {
        self.stateLabel.text = @"Tap to turn on";
        self.peripheralManager = nil;
    }
}

@end
