//
//  NineMen_sMorrisApp.swift
//  NineMen'sMorris
//
//  Created by Łukasz Michalak on 06/09/2025.
//

import SwiftUI

@main
struct NineMen_sMorrisApp: App {
    var body: some Scene {
        WindowGroup {
            GameView()
        }
        .commandsRemoved()
        .commands {
            CommandMenu("Game") {
                Button("Play 9 men's morris") {
                    NotificationCenter.default.post(name: Notification.Name.start9mens, object: nil)
                }
                Button("Play 3 men's morris") {
                    NotificationCenter.default.post(name: Notification.Name.start3mens, object: nil)
                }
            }
        }
    }
}
