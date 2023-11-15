//
//  LazyNavigationView.swift
//  SwiftCoinTutorial
//
//  Created by bastien giat on 23/02/2023.
//

import SwiftUI

struct LazyNavigationView<Content: View> : View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
    
}
