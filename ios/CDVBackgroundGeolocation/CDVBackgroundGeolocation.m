////
//  CDVBackgroundGeolocation
//
//  Created by Chris Scott <chris@transistorsoft.com> on 2013-06-15
//
#import "CDVBackgroundGeolocation.h"

@implementation CDVBackgroundGeolocation {
}

@synthesize syncCallbackId;
@synthesize bgDelegate;

- (void)pluginInitialize
{
    bgDelegate = [[BackgroundGeolocationDelegate alloc] init];
    bgDelegate.onLocationChanged = [self createLocationChangedHandler];
}

/**
 * configure plugin
 * @param {Number} stationaryRadius
 * @param {Number} distanceFilter
 * @param {Number} locationTimeout
 */
- (void) configure:(CDVInvokedUrlCommand*)command
{
    NSLog(@"CDVBackgroundGeolocation configure called");

    NSDictionary *config = [command.arguments objectAtIndex:0];
    self.syncCallbackId = command.callbackId;
    
    [bgDelegate configure:config];
}

- (void) addStationaryRegionListener:(CDVInvokedUrlCommand*)command
{
//    if (self.stationaryRegionListeners == nil) {
//        self.stationaryRegionListeners = [[NSMutableArray alloc] init];
//    }
//    [self.stationaryRegionListeners addObject:command.callbackId];
//    if (stationaryRegion) {
//        [self queue:stationaryLocation type:@"stationary"];
//    }
}

- (void) setConfig:(CDVInvokedUrlCommand*)command
{
    NSLog(@"- CDVBackgroundGeolocation setConfig");
    NSDictionary *config = [command.arguments objectAtIndex:0];

    [self.commandDelegate runInBackground:^{
        [bgDelegate setConfig:config];
        
        CDVPluginResult* result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

/**
 * Turn on background geolocation
 * in case of failure it calls error callback from configure method
 * may fire two callback when location services are disabled and when authorization failed
 */
- (void) start:(CDVInvokedUrlCommand*)command
{
    NSLog(@"- CDVBackgroundGeolocation starting attempt");

    [bgDelegate start];
    
    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

/**
 * Turn it off
 */
- (void) stop:(CDVInvokedUrlCommand*)command
{
    NSLog(@"- CDVBackgroundGeolocation stop");
    
    [bgDelegate stop];

    CDVPluginResult* result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

}

/**
 * Change pace to moving/stopped
 * @param {Boolean} isMoving
 */
- (void) onPaceChange:(CDVInvokedUrlCommand *)command
{
    BOOL isMoving = [[command.arguments objectAtIndex: 0] boolValue];
    NSLog(@"- CDVBackgroundGeolocation onPaceChange %d", isMoving);
    [bgDelegate onPaceChange:isMoving];
}

/**
 * Fetches current stationaryLocation
 */
//- (void) getStationaryLocation:(CDVInvokedUrlCommand *)command
//{
//    NSLog(@"- CDVBackgroundGeolocation getStationaryLocation");
//
//    // Build a resultset for javascript callback.
//    CDVPluginResult* result = nil;
//
//    if (stationaryLocation) {
//        NSMutableDictionary *returnInfo = [self locationToHash:stationaryLocation];
//
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:returnInfo];
//    } else {
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
//    }
//    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//}

- (void) isLocationEnabled:(CDVInvokedUrlCommand*)command
{
    // TODO: yet to be implemented
}

- (void) showAppSettings:(CDVInvokedUrlCommand*)command
{
    [bgDelegate showAppSettings];
}

- (void) showLocationSettings:(CDVInvokedUrlCommand*)command
{
    [bgDelegate showLocationSettings];
}

- (void) watchLocationMode:(CDVInvokedUrlCommand*)command
{
    // TODO: yet to be implemented
}

- (void) stopWatchingLocationMode:(CDVInvokedUrlCommand*)command
{
     // TODO: yet to be implemented
}

- (void) getLocations:(CDVInvokedUrlCommand*)command
{
    // TODO: yet to be implemented
}

- (void) deleteLocation:(CDVInvokedUrlCommand*)command
{
    // TODO: yet to be implemented
}

- (void) deleteAllLocations:(CDVInvokedUrlCommand*)command
{
    // TODO: yet to be implemented    
}

-(void (^)(NSMutableDictionary *location)) createLocationChangedHandler {
    return ^(NSMutableDictionary *location) {
        NSLog(@"- CDVBackgroundGeolocation onLocationChanged");
        CDVPluginResult* result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:location];
        [result setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:result callbackId:self.syncCallbackId];
    };
}

@end
