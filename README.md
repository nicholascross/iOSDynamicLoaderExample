# iOS Dynamic Embedded Framework Loading
An example project showing embedded framework with conditional dynamic class loading based on scheme.

## DynamicLoader.framework
The interfaces to any dynamically loaded classes are defined in a seperate framework that is always available to the app.  It is both *embedded* and *linked* with the app `DynamicLoaderExampleApp.app`.

```swift
public protocol AnInterfaceAvailableToApp {
    static func doSomething()
    static func doSomethingElse() -> String
}
```

## DynamicFramework.framework
This is the framework that is conditionally included in the app.  The framework is always *embedded* but **not** *linked* with the app `DynamicLoaderExampleApp.app`. It is *"linked"* with the framework that defines its interface `DynamicLoader.framework`.

Any class that we want to dynamically load must implement an interface that the app is aware of.

```swift
public class DynamicClassExample : AnInterfaceAvailableToApp {
    
    public static func doSomething() {
        print("loaded dynamic class")
    }
    
    public static func doSomethingElse() -> String {
        return "Hello, World!"
    }
    
}
```

Classes are loaded by name using the framework name.
```swift
let bundleURL = NSBundle.URLForResource("DynamicFramework", withExtension: "framework", subdirectory: "Frameworks", inBundleWithURL: NSBundle.mainBundle().bundleURL)
```

The framework is loaded before the class is retrieved by name.
```swift
let bundle = NSBundle(URL: bundleURL)
bundle.load()
```

Swift class names should include the module name.
```swift
 let aClass = NSClassFromString("DynamicFramework.DynamicClassExample")
```

## DynamicLoaderExampleApp.app
The app uses the interfaces provided by the `DynamicLoader.framework` and nothing from `DynamicFramework.framework` directly.
```swift
 guard let aConformingClass = aClass as? AnInterfaceAvailableToApp.Type else {
    //if the class was not loaded return nil
    return nil
 }
 
 //if the class was loaded then we can do something
 aConformingClass.doSomething()
```

There is an additional build phase for the app that will conditionally remove dynamic framework `DynamicFramework.framework` depending on the scheme being run.  This is often helpful for inlcuding additional code during development or testing but leaving it out of the a release.
```bash
if [ "${CONFIGURATION}" == "Release" ]; then
rm -rf "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/Frameworks/DynamicFramework.framework"
fi
```
