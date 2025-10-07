import SwiftUI

@main
struct NineMen_sMorrisApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(variant: .ThreeMensMorris)
        }
        .commandsRemoved()
    }
}
