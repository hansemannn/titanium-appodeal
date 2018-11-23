/**
 * ti.appodeal
 *
 * Created by Your Name
 * Copyright (c) 2018 Your Company. All rights reserved.
 */

#import "TiAppodealModule.h"
#import "TiApp.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiAppodealModule

#pragma mark Internal

// This is generated for your module, please do not change it
- (id)moduleGUID
{
  return @"1cd6a999-8386-4f54-b81a-6cad6beaae4b";
}

// This is generated for your module, please do not change it
- (NSString *)moduleId
{
  return @"ti.appodeal";
}

#pragma Public APIs

- (void)initialize:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);
  
  NSString *apiKey = args[@"apiKey"];
  NSNumber *hasConsent = args[@"hasConsent"];

  // Initialize SDK. This can throw in certain situations
  @try {
    [Appodeal initializeWithApiKey:apiKey
                             types:(AppodealAdTypeInterstitial | AppodealAdTypeRewardedVideo | AppodealAdTypeBanner | AppodealAdTypeNativeAd)
                        hasConsent:hasConsent.boolValue];
  } @catch (NSException *e) {
    DebugLog(@"[ERROR] Could not initialize SDK: %@", e.reason);
  }

  // Set delegates
  [Appodeal setInterstitialDelegate:self];
  [Appodeal setRewardedVideoDelegate:self];
  [Appodeal setBannerDelegate:self];
  [Appodeal setNativeAdDelegate:self];
}

- (void)setTestingEnabled:(NSNumber *)testingEnabled
{
  [Appodeal setTestingEnabled:testingEnabled.boolValue];
}

- (void)setLogLevel:(NSNumber *)logLevel
{
  [Appodeal setLogLevel:[TiUtils intValue:logLevel]];
}

- (void)showAd:(id)showStyle
{
  ENSURE_SINGLE_ARG(showStyle, NSNumber);
  [Appodeal showAd:[TiUtils intValue:showStyle] rootViewController:TiApp.app.controller];
}

- (void)hideBanner:(id)args
{
  [Appodeal hideBanner];
}
  
  - (NSDictionary *)rewardForPlacement:(id)placement
  {
    ENSURE_SINGLE_ARG(placement, NSString);
    
    id<APDReward> reward = [Appodeal rewardForPlacement:placement];

    return @{
      @"amount": @(reward.amount),
      @"currencyName": reward.currencyName
    };
  }

#pragma mark AppodealInterstitialDelegate

- (void)interstitialDidLoadAdIsPrecache:(BOOL)precache
{
  [self fireEvent:@"interstitialDidLoadAdIsPrecache" withObject:@{ @"precache": @(precache) }];
}

- (void)interstitialDidFailToLoadAd
{
  [self fireEvent:@"interstitialDidFailToLoadAd"];
}

- (void)interstitialDidExpired
{
  [self fireEvent:@"interstitialDidExpired"];
}

- (void)interstitialDidFailToPresent
{
  [self fireEvent:@"interstitialDidFailToPresent"];
}

- (void)interstitialWillPresent
{
  [self fireEvent:@"interstitialWillPresent"];
}

- (void)interstitialDidDismiss
{
  [self fireEvent:@"interstitialDidDismiss"];
}

- (void)interstitialDidClick
{
  [self fireEvent:@"interstitialDidClick"];
}

#pragma mark APDRewardedVideoDelegate

- (void)rewardedVideoDidLoadAdIsPrecache:(BOOL)precache
{
  [self fireEvent:@"rewardedVideoDidLoadAdIsPrecache" withObject:@{ @"precache": @(precache) }];
}

- (void)rewardedVideoDidFailToLoadAd
{
  [self fireEvent:@"rewardedVideoDidFailToLoadAd"];
}

- (void)rewardedVideoDidFailToPresentWithError:(NSError *)error
{
  [self fireEvent:@"rewardedVideoDidFailToPresentWithError" withObject:@{ @"error": error.localizedDescription }];
}

- (void)rewardedVideoDidPresent
{
  [self fireEvent:@"rewardedVideoDidPresent"];
}

- (void)rewardedVideoWillDismissAndWasFullyWatched:(BOOL)wasFullyWatched
{
  [self fireEvent:@"rewardedVideoWillDismissAndWasFullyWatched" withObject:@{ @"wasFullyWatched": @(wasFullyWatched) }];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName
{
  NSMutableDictionary *event = [NSMutableDictionary dictionaryWithObject:@(rewardAmount) forKey:@"rewardAmount"];
  if (rewardName != nil) {
    event[@"rewardName"] = rewardName;
  }
  [self fireEvent:@"rewardedVideoDidFinish" withObject:event];
}

- (void)rewardedVideoDidExpired
{
  [self fireEvent:@"rewardedVideoDidExpired"];
}

#pragma mark AppodealBannerDelegate

- (void)bannerDidLoadAdIsPrecache:(BOOL)precache
{
  [self fireEvent:@"bannerDidLoadAdIsPrecache" withObject:@{ @"precache": @(precache) }];
}

- (void)bannerDidFailToLoadAd
{
  [self fireEvent:@"bannerDidFailToLoadAd"];
}

- (void)bannerDidExpired
{
  [self fireEvent:@"bannerDidExpired"];
}

- (void)bannerDidClick
{
  [self fireEvent:@"bannerDidClick"];
}

- (void)bannerDidShow
{
  [self fireEvent:@"bannerDidShow"];
}

#pragma mark AppodealNativeAdDelegate

- (void)didLoadNativeAds:(NSInteger)count
{
  [self fireEvent:@"didLoadNativeAds" withObject:@{ @"count": @(count) }];
}

- (void)didFailToLoadNativeAdsWithError:(nonnull NSError *)error
{
  [self fireEvent:@"didFailToLoadNativeAdsWithError" withObject:@{ @"error": error.localizedDescription }];
}

#pragma mark Constants

MAKE_SYSTEM_PROP(LOG_LEVEL_OFF, APDLogLevelOff);
MAKE_SYSTEM_PROP(LOG_LEVEL_ERROR, APDLogLevelError);
MAKE_SYSTEM_PROP(LOG_LEVEL_WARNING, APDLogLevelWarning);
MAKE_SYSTEM_PROP(LOG_LEVEL_INFO, APDLogLevelInfo);
MAKE_SYSTEM_PROP(LOG_LEVEL_DEBUG, APDLogLevelDebug);
MAKE_SYSTEM_PROP(LOG_LEVEL_VERBOSE, APDLogLevelVerbose);

MAKE_SYSTEM_PROP(SHOW_STYLE_INTERSTITIAL, AppodealShowStyleInterstitial);
MAKE_SYSTEM_PROP(SHOW_STYLE_BANNER_BOTTOM, AppodealShowStyleBannerBottom);
MAKE_SYSTEM_PROP(SHOW_STYLE_BANNER_TOP, AppodealShowStyleBannerTop);
MAKE_SYSTEM_PROP(SHOW_STYLE_REWARDED_VIDEO, AppodealShowStyleRewardedVideo);

@end
