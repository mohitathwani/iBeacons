//
//  ReceiverViewController.h
//  iBeaconDemo
//
//  Created by Labs on 3/4/15.
//  Copyright (c) 2015 Tera Mo Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@import CoreLocation;

@interface ReceiverViewController : UIViewController

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
