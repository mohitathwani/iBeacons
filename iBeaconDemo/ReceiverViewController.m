//
//  ReceiverViewController.m
//  iBeaconDemo
//
//  Created by Labs on 3/4/15.
//  Copyright (c) 2015 Tera Mo Labs. All rights reserved.
//

#import "ReceiverViewController.h"

@interface ReceiverViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *beaconFoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityUUIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@end

@implementation ReceiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.delegate = self;
    [self setupRegion];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}

- (void)setupRegion {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:kBundleID];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    self.distanceLabel.text = @"Left region";
//        [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    self.beaconFoundLabel.text = @"No";
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
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
    self.rssiLabel.text = [NSString stringWithFormat:@"%i", beacon.rssi];
}


@end
