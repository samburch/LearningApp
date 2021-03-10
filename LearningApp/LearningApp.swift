//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Sam Burch on 10/03/2021.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
