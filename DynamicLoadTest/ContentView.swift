//
//  ContentView.swift
//  DynamicLoadTest
//
//  Created by Nicholas Cross on 19/6/2022.
//

import SwiftUI
import Loader

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }.onAppear {
            let aClass = DynamicClassLoader.loadDynamic(classNamed: "Plugin.DynamicClassExample", fromFrameworkNamed: "Plugin")
            
            if let somethingDone = aClass?.doSomethingElse() {
                print("\(somethingDone)")
            }
            else {
                print("Class wasn't loaded")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
