//
//  AppDelegate.swift
//  DynamicLoaderExampleApp
//
//  Created by Nicholas Cross on 3/07/2016.
//  Copyright © 2016 Nicholas Cross. All rights reserved.
//

import UIKit
import DynamicLoader

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let aClass = DynamicClassLoader.loadDynamic("DynamicFramework.DynamicClassExample", fromFrameworkNamed: "DynamicFramework")
        
        if let somethingDone = aClass?.doSomethingElse() {
            print("\(somethingDone)")
        }
        else {
            print("Class wasn't loaded")
        }
        
        return true
    }

}

