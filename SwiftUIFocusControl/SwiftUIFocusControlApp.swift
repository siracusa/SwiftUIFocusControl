//
//  SwiftUIFocusControlApp.swift
//  SwiftUIFocusControl
//
//  Created by John Siracusa on 1/4/25.
//

import SwiftUI

@main
struct SwiftUIFocusControlApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 400, height: 200)
    }
}
