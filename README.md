ADNKit
======

ADNKit is a Objective-C framework for building App.net iOS and OS X applications. The guiding design principles are:
* Simple and easy to understand API
* Very quick to get started and passed App.net Auth
* 100% ADN API support
* Useful convenience methods and objects
* AFNetworking should be the only dependency

# Current State
ADNKit is very much a work in progress right now, and 100% of the ADN API has not yet been reached.

# Getting Started
### Installation
ADNKit makes use of submodules for its dependencies. After cloning the repo, make sure to run `git submodule update --init --recursive` from the top level before trying to build the code. There is also a Releases folder containing stable binary releases.

**It's also important to note that AFNetworking is compiled in as part of the library and does not need to be added to your project.**

### Your First App.net App

##### Username/Password Authentication

App.net recommends that any app being submitted to the Mac or iOS App Store use username/password authentication instead of OAuth ([source](http://developers.app.net), see "Registering your app"). You can find out more about Password Authentication and how to apply for it [here](http://developers.app.net/docs/authentication/flows/password/).

Once you have been approved for username/password auth, **getting authenticated with ADNKit is a single method call:**

```objc
/* this assumes you have two text fields, usernameField and passwordField */

// ask for permission to see user information, fetch their streams, and send Posts
ADNAuthScope requestedScopes = ADNAuthScopeBasic | ADNAuthScopeStream | ADNAuthScopeWritePost;

// handler to call when finished authenticating
id handler = ^(BOOL success, NSError *error) {
	if (success) {
		NSLog(@"we are authenticated and ready to make API calls!");
	} else {
		NSLog(@"could not authenticate, error: %@", error);
	}
};

// authenticate, calling the handler block when complete
[[ADNClient sharedClient] authenticateUsername:usernameField.text
									  password:passwordField.text
									  clientID:@"xxxxxx"
						   passwordGrantSecret:@"zzzzzz"
						         	authScopes:requestedScopes
						     completionHandler:handler];
```

Once the completion block is called with a successful response, you are completely good to go and can start using the rest of the API calls.

##### OAuth Authentication

While not being the preferred approach for native applications, ADNKit will also help you out with web OAuth authentication ([more info](http://developers.app.net/docs/authentication/flows/web/)) if that's the route you choose to take (it's sometimes faster to start with because it doesn't require explicit approval like username/password auth does).

For the redirectURI, you should use a URL scheme that your app is registered to handle ([Apple documentation](http://developer.apple.com/library/ios/#documentation/iphone/conceptual/iphoneosprogrammingguide/AdvancedAppTricks/AdvancedAppTricks.html#//apple_ref/doc/uid/TP40007072-CH7-SW50)). Support the route (aka, "/auth") is very easy to do with something like [JLRoutes](https://github.com/joeldev/JLRoutes).

Using the method below, you can generate an NSURLRequest that can be loaded in a webview to provide the user with a way to auth.
```objc
// ask for permission to see user information, fetch their streams, and send Posts
ADNAuthScope requestedScopes = ADNAuthScopeBasic | ADNAuthScopeStream | ADNAuthScopeWritePost;

NSURLRequest *request = [[ADNClient sharedClient] webAuthRequestForClientID:@"xxxxxx"
														        redirectURI:@"myapp://auth"
													           responseType:ADNWebAuthResponseTypeToken
													             authScopes:requestedScopes
													                  state:nil
												          appStoreCompliant:YES];
[myWebView loadRequest:request];
```

Currently ADNKit does not help you handle anything after passing the request to the webview, until you have an access token. Once you have the access token, you can hand it directly to the shared ADNClient and you're ready to use the API.

##### Setting the access token
```objc
[ADNClient sharedClient].accessToken = theAccessToken;
```

You should call this if the user has already authorized the application and you have an access token to use. Authentication only needs to be done when the token is no longer valid or the user has never authorized the app before.

# Dependencies
ADNKit uses the following dependencies:
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)

The following built-in frameworks are used:
* CoreLocation.framework
* SystemConfiguration.framework
* MobileCoreServices.framework (iOS only)

# License
> (decide on BSD or MIT)