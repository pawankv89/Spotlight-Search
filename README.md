
Spotlight-Search
=========

## iOS Spotlight Search | Core Spotlight
------------
 Added Some screens here.
 
[![](https://github.com/pawankv89/Spotlight-Search/blob/master/images/screen_1.PNG)]
[![](https://github.com/pawankv89/Spotlight-Search/blob/master/images/screen_2.PNG)]
[![](https://github.com/pawankv89/Spotlight-Search/blob/master/images/screen_3.PNG)]


## Usage
------------
 
Integration Steps
Add SpotlightManager.swift file to your project.

Add this delegate function in AppDelegate.swift to handle Spotlight Item tap action.

```swift
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {

// Called when Spotlight item tapped. Do anything with specified data.
SpotlightManager.sharedInstance.spotlightItemTapAction(userActivity)

return true
}
```

There is a sample function in SpotlightManager that you can simply call. In this project it is called on application launch in didFinishLaunchingWithOptions delegate in AppDelegate.swift.

```swift
SpotlightManager.sharedInstance.reloadInitialItems()
```

When user tap to an item in Spotlight Search results, spotlightItemTapAction function is called. You can edit this function to do any action you want.

##Refrence:-
https://hackernoon.com/how-to-add-spotlight-support-to-your-ios-app-4a89054aff89


## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each this release can be found in the [CHANGELOG](CHANGELOG.mdown). 
