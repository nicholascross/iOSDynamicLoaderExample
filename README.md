# iOS Dynamic Embedded Framework Loading
Example project showing embedded framework with conditional dynamic class loading based on scheme.

## DynamicLoader.framework
The interface to any dynamically loaded classes are defined in a seperate framework that is always available to the app.  It is both "embedded" and "linked" with the app `DynamicLoaderExampleApp.app`.

## DynamicFramework.framework
This is the framework that is conditionally included in the app.  The framework is always "embedded" but not "linked" with the app. It is "linked" with the framework that defines its interface `DynamicLoader.framework`.

Classes are loaded by name using the framework name.
```
let bundleURL = NSBundle.URLForResource(framework, withExtension: "framework", subdirectory: "Frameworks", inBundleWithURL: NSBundle.mainBundle().bundleURL), let bundle = NSBundle(URL: bundleURL)
```
The framework is loaded before the class is retrieved by name.
```
bundle.load()
```

Swift class names should include the module name.
```
 let aClass = NSClassFromString("DynamicFramework.DynamicClassExample")
```

## DynamicLoaderExampleApp.app
The app uses the interfaces provided by the `DynamicLoader.framework` and nothing from `DynamicFramework.framework` directly.  There is an additional build phase for the app that will conditionally remove dynamic framework depending on the scheme being run.  This is often helpful for inlcuding additional code during development or testing but leaving it out of the a release.
