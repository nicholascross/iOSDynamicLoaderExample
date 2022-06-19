//
//  DynamicClassExample.swift
//  Plugin
//
//  Created by Nicholas Cross on 19/6/2022.
//

import Foundation
import Loader

public class DynamicClassExample : DynamicLoadableClass {
    
    public static func loadDynamic() {
        print("loaded dynamic class")
    }
    
    public static func doSomethingElse() -> String {
        return "Hello, World!"
    }
    
}
