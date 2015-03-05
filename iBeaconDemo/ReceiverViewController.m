//
//  ReceiverViewController.m
//  iBeaconDemo
//
//  Created by Labs on 3/4/15.
//  Copyright (c) 2015 Tera Mo Labs. All rights reserved.
//

#import "ReceiverViewController.h"

@interface ReceiverViewController ()
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *beaconFoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityUUIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@property (strong, nonatomic) MABeaconReceiver *beaconReceiver;
@end

@implementation ReceiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.beaconReceiver = [[MABeaconReceiver alloc] initWithUUID:kUUID bundleID:kBundleID];
    self.beaconReceiver.delegate = self;
}

-(void)foundBacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    NSSortDescriptor *nearestSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rssi" ascending:YES];
    
    NSArray *sortedBeacons = [beacons sortedArrayUsingDescriptors:@[nearestSortDescriptor]];
    
    CLBeacon *beacon = [sortedBeacons lastObject];
    
    self.beaconFoundLabel.text = @"Yes";
    self.proximityUUIDLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    if (beacon.proximity == CLProximityUnknown) {
        self.distanceLabel.text = @"Unknown Proximity";
        self.view.backgroundColor = [UIColor grayColor];
    } else if (beacon.proximity == CLProximityImmediate) {
        self.distanceLabel.text = @"Immediate";
        self.view.backgroundColor = [UIColor greenColor];
    } else if (beacon.proximity == CLProximityNear) {
        self.distanceLabel.text = @"Near";
        self.view.backgroundColor = [UIColor orangeColor];
    } else if (beacon.proximity == CLProximityFar) {
        self.distanceLabel.text = @"Far";
        self.view.backgroundColor = [UIColor redColor];
    }
    self.rssiLabel.text = [NSString stringWithFormat:@"%li", (long)beacon.rssi];
}

@end
