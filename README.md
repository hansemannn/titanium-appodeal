# Titanium Appodeal Module

Support for the native Appodeal SDK (iOS / Android) in Titanium.

## Build

### Android
```
appc run -p android --build-only
```

### iOS
1. Download the `Appodeal.framework` (1.1 GB) from the Appodeal website
2. Place the framework in `ios/platform`
3. Compile the module with `appc run -p ios --build-only`

## Example

```js
var Appodeal = require('ti.appodeal');

var win = Ti.UI.createWindow({
  backgroundColor: '#fff'
});

// iOS-key by default
var apiKey = '884828d5af5336eed49af68da4e909a1e43e316f92fe4cae'

// if on Android, use specific key. Appodeal requires one key for each platform
if (Ti.Platform.osname === 'android') {
  apiKey = '5c542f06aec9c1d43887167a1896f8cebd450c50c0090633';
}

win.addEventListener('open', function () {
  Appodeal.initialize({
    apiKey: apiKey,
    hasConsent: true
  }, {});

  // One of:
  //   - Appodeal.LOG_LEVEL_OFF
  //   - Appodeal.LOG_LEVEL_DEBUG
  //   - Appodeal.LOG_LEVEL_VERBOSE
  //   - Appodeal.LOG_LEVEL_ERROR (iOS only)
  //   - Appodeal.LOG_LEVEL_WARNING (iOS only)
  //   - Appodeal.LOG_LEVEL_INFO (iOS only)
  Appodeal.logLevel = Appodeal.LOG_LEVEL_VERBOSE;
  Appodeal.testingEnabled = true;

  Appodeal.addEventListener('interstitialDidLoadAdIsPrecache', function () { Ti.API.info('interstitialDidLoadAdIsPrecache'); });
  Appodeal.addEventListener('interstitialDidFailToLoadAd', function () { Ti.API.info('interstitialDidFailToLoadAd'); });
  Appodeal.addEventListener('interstitialDidExpired', function () { Ti.API.info('interstitialDidExpired'); });
  Appodeal.addEventListener('interstitialDidFailToPresent', function () { Ti.API.info('interstitialDidFailToPresent'); });
  Appodeal.addEventListener('interstitialWillPresent', function () { Ti.API.info('interstitialWillPresent'); });
  Appodeal.addEventListener('interstitialDidDismiss', function () { Ti.API.info('interstitialDidDismiss'); });
  Appodeal.addEventListener('interstitialDidClick', function () { Ti.API.info('interstitialDidClick'); });

  Appodeal.addEventListener('rewardedVideoDidLoadAdIsPrecache', function () { Ti.API.info('rewardedVideoDidLoadAdIsPrecache'); });
  Appodeal.addEventListener('rewardedVideoDidFailToLoadAd', function () { Ti.API.info('rewardedVideoDidFailToLoadAd'); });
  Appodeal.addEventListener('rewardedVideoDidFailToPresentWithError', function (e) { Ti.API.info('rewardedVideoDidFailToPresentWithError'); Ti.API.error(e.error); });
  Appodeal.addEventListener('rewardedVideoDidPresent', function () { Ti.API.info('rewardedVideoDidPresent'); });
  Appodeal.addEventListener('rewardedVideoWillDismissAndWasFullyWatched', function () { Ti.API.info('rewardedVideoWillDismissAndWasFullyWatched'); });
  Appodeal.addEventListener('rewardedVideoDidFinish', function () { Ti.API.info('rewardedVideoDidFinish'); });
  Appodeal.addEventListener('rewardedVideoDidExpired', function () { Ti.API.info('rewardedVideoDidExpired'); });

  Appodeal.addEventListener('bannerDidLoadAdIsPrecache', function () { Ti.API.info('bannerDidLoadAdIsPrecache'); });
  Appodeal.addEventListener('bannerDidFailToLoadAd', function () { Ti.API.info('bannerDidFailToLoadAd'); });
  Appodeal.addEventListener('bannerDidExpired', function () { Ti.API.info('bannerDidExpired'); });
  Appodeal.addEventListener('bannerDidClick', function () { Ti.API.info('bannerDidClick'); });
  Appodeal.addEventListener('bannerDidShow', function () { Ti.API.info('bannerDidShow'); });

  Appodeal.addEventListener('didLoadNativeAds', function () { Ti.API.info('didLoadNativeAds'); });
  Appodeal.addEventListener('didFailToLoadNativeAdsWithError', function () { Ti.API.info('didFailToLoadNativeAdsWithError'); Ti.API.error(e.error); });
});

var btn = Ti.UI.createButton({
  title: 'Show Ad!'
});

btn.addEventListener('click', function () {
  // One of:
  //   - Appodeal.SHOW_STYLE_INTERSTITIAL
  //   - Appodeal.SHOW_STYLE_BANNER_TOP
  //   - Appodeal.SHOW_STYLE_BANNER_BOTTOM
  //   - Appodeal.SHOW_STYLE_REWARDED_VIDEO
  Appodeal.showAd(Appodeal.SHOW_STYLE_REWARDED_VIDEO);
});

win.add(btn);
win.open();
```

## License

UNLICENSED

## Author

Hans Knöchel (Lambus GmbH)
