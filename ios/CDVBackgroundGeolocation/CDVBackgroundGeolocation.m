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

//- (void) setConfig:(CDVInvokedUrlCommand*)command
//{
//    NSLog(@"- CDVBackgroundGeolocation setConfig");
//    NSDictionary *config = [command.arguments objectAtIndex:0];
//
//    [self.commandDelegate runInBackground:^{
//        [bgDelegate setConfig:config];
//        
//        CDVPluginResult* result = nil;
//        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
//        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//    }];
//}

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
    BOOL isLocationEnabled = [bgDelegate isLocationEnabled];
    NSLog(@"- CDVBackgroundGeolocation isLocationEnabled %d", isLocationEnabled);
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isLocationEnabled];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
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

/**
 * Called by js to signify the end of a background-geolocation event
 */
-(void) finish:(CDVInvokedUrlCommand*)command
{
    NSLog(@"- CDVBackgroundGeoLocation finish");
    [bgDelegate finish];
}

/**
 * Suspend.  Turn on passive location services
 */
-(void) onSuspend:(NSNotification *) notification
{
//    NSLog(@"- CDVBackgroundGeoLocation suspend (enabled? %d)", enabled);
//    suspendedAt = [NSDate date];
//    
//    if (enabled) {
//        // Sample incoming stationary-location candidate:  Is it within the current stationary-region?  If not, I guess we're moving.
//        if (!isMoving && stationaryRegion) {
//            if ([self locationAge:stationaryLocation] < (5 * 60.0)) {
//                if (isDebugging) {
//                    AudioServicesPlaySystemSound (acquiredLocationSound);
//                    [self notify:[NSString stringWithFormat:@"Continue stationary\n%f,%f", [stationaryLocation coordinate].latitude, [stationaryLocation coordinate].longitude]];
//                }
//                [self queue:stationaryLocation type:@"stationary"];
//                return;
//            }
//        }
//        [self setPace: isMoving];
//    }
}

/**@
 * Resume.  Turn background off
 */
-(void) onResume:(NSNotification *) notification
{
    NSLog(@"- CDVBackgroundGeoLocation resume");
//    if (enabled) {
//        [self stopUpdatingLocation];
//    }
}

/**@
 * Termination. Checks to see if it should turn off
 */
-(void) onAppTerminate
{
    NSLog(@"- CDVBackgroundGeoLocation appTerminate");
//    if (enabled && stopOnTerminate) {
//        NSLog(@"- CDVBackgroundGeoLocation stoping on terminate");
//        
//        enabled = NO;
//        isMoving = NO;
//        
//        [self stopUpdatingLocation];
//        [locationManager stopMonitoringSignificantLocationChanges];
//        if (stationaryRegion != nil) {
//            [locationManager stopMonitoringForRegion:stationaryRegion];
//            stationaryRegion = nil;
//        }
//    }
}

/**
 * If you don't stopMonitoring when application terminates, the app will be awoken still when a
 * new location arrives, essentially monitoring the user's location even when they've killed the app.
 * Might be desirable in certain apps.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
//    [locationManager stopMonitoringSignificantLocationChanges];
//    [locationManager stopUpdatingLocation];
//    if (stationaryRegion != nil) {
//        [locationManager stopMonitoringForRegion:stationaryRegion];
//    }
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
