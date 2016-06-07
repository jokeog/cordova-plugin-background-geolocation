//
//  CDVBackgroundGeolocation.h
//
//  Created by Chris Scott <chris@transistorsoft.com>
//

#import <Cordova/CDVPlugin.h>
#import "BackgroundGeolocationDelegate.h"

@interface CDVBackgroundGeolocation : CDVPlugin

@property (nonatomic, strong) NSString* syncCallbackId;
@property (nonatomic, strong) BackgroundGeolocationDelegate* bgDelegate;

- (void) configure:(CDVInvokedUrlCommand*)command;
- (void) start:(CDVInvokedUrlCommand*)command;
- (void) stop:(CDVInvokedUrlCommand*)command;
- (void) finish:(CDVInvokedUrlCommand*)command;
- (void) onPaceChange:(CDVInvokedUrlCommand*)command;
//- (void) setConfig:(CDVInvokedUrlCommand*)command;
//- (void) addStationaryRegionListener:(CDVInvokedUrlCommand*)command;
//- (void) getStationaryLocation:(CDVInvokedUrlCommand *)command;
- (void) isLocationEnabled:(CDVInvokedUrlCommand*)command;
- (void) showAppSettings:(CDVInvokedUrlCommand*)command;
- (void) showLocationSettings:(CDVInvokedUrlCommand*)command;
- (void) watchLocationMode:(CDVInvokedUrlCommand*)command;
- (void) stopWatchingLocationMode:(CDVInvokedUrlCommand*)command;
- (void) getLocations:(CDVInvokedUrlCommand*)command;
- (void) deleteLocation:(CDVInvokedUrlCommand*)command;
- (void) deleteAllLocations:(CDVInvokedUrlCommand*)command;
- (void) onSuspend:(NSNotification *)notification;
- (void) onResume:(NSNotification *)notification;
- (void) onAppTerminate;

@end
