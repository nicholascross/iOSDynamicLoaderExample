//
//  DynamicClassExample.swift
//  DynamicLoader
//
//  Created by Nicholas Cross on 3/07/2016.
//  Copyright © 2016 Nicholas Cross. All rights reserved.
//

import Foundation
import DynamicLoader

public class DynamicClassExample : DynamicLoadableClass {
    
    public static func loadDynamic() {
        print("loaded dynamic class")
    }
    
    public static func doSomethingElse() -> String {
        return "Hello, World!"
    }
    
}