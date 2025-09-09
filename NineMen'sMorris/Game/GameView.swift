import SwiftUI

struct GameView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        Circle()
            .fill(.pink)
            .position(viewModel.getBoard())
    }
}

#Preview {
    GameView()
}
