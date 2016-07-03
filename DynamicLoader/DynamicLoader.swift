//
//  DynamicLoader.swift
//  DynamicLoader
//
//  Created by Nicholas Cross on 3/07/2016.
//  Copyright © 2016 Nicholas Cross. All rights reserved.
//

import Foundation

public class DynamicClassLoader {
    
    public static func loadDynamic(classNamed:String, fromFrameworkNamed framework: String) -> DynamicLoadableClass.Type? {
        guard let bundleURL = NSBundle.URLForResource(framework, withExtension: "framework", subdirectory: "Frameworks", inBundleWithURL: NSBundle.mainBundle().bundleURL), let bundle = NSBundle(URL: bundleURL) else {
            return nil
        }
        
        return loadDynamic(classNamed, fromBundle: bundle)
    }
    
    public static func loadDynamic(classNamed: String, fromBundle bundle: NSBundle) -> DynamicLoadableClass.Type? {
        bundle.load()
        
        guard let aClass = NSClassFromString(classNamed) else {
            return nil
        }
        
        return loadDynamicClass(aClass)
    }
    
    private static func loadDynamicClass(aClass: AnyClass) -> DynamicLoadableClass.Type?  {
        guard let loadable = aClass as? DynamicLoadableClass.Type else {
            return nil
        }
        
        let aClass = loadable.loadDynamic()
        
        return loadable
    }
    
}

public protocol DynamicLoadableClass {
    static func loadDynamic()
}