# iOS Dynamic Embedded Framework Loading
An example project showing embedded framework with conditional dynamic class loading based on scheme.

## DynamicLoader.framework
The interfaces to any dynamically loaded classes are defined in a seperate framework that is always available to the app.  It is both *embedded* and *linked* with the app `DynamicLoaderExampleApp.app`.

```
public protocol AnInterfaceAvailableToApp {
    static func doSomething()
    static func doSomethingElse() -> String
}
```

## DynamicFramework.framework
This is the framework that is conditionally included in the app.  The framework is always *embedded* but **not** *linked* with the app `DynamicLoaderExampleApp.app`. It is *"linked"* with the framework that defines its interface `DynamicLoader.framework`.

Classes are loaded by name using the framework name.
```
let bundleURL = NSBundle.URLForResource("DynamicFramework", withExtension: "framework", subdirectory: "Frameworks", inBundleWithURL: NSBundle.mainBundle().bundleURL)
```

The framework is loaded before the class is retrieved by name.
```
let bundle = NSBundle(URL: bundleURL)
bundle.load()
```

Swift class names should include the module name.
```
 let aClass = NSClassFromString("DynamicFramework.DynamicClassExample")
```

## DynamicLoaderExampleApp.app
The app uses the interfaces provided by the `DynamicLoader.framework` and nothing from `DynamicFramework.framework` directly.
```
 guard let aConformingClass = aClass as? AnInterfaceAvailableToApp.Type else {
    //if the class was not loaded return nil
    return nil
 }
 
 //if the class was loaded then we can do something
 aConformingClass.doSomething()
```

There is an additional build phase for the app that will conditionally remove dynamic framework `DynamicFramework.framework` depending on the scheme being run.  This is often helpful for inlcuding additional code during development or testing but leaving it out of the a release.
```
if [ "${CONFIGURATION}" == "Release" ]; then
rm -rf "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/Frameworks/DynamicFramework.framework"
fi
```
