//
//  BeaconViewController.h
//  iBeaconDemo
//
//  Created by Labs on 3/4/15.
//  Copyright (c) 2015 Tera Mo Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@import CoreLocation;
@import CoreBluetooth;

@interface BeaconViewController : UIViewController<CBPeripheralManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *appBundleLabel;

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end
