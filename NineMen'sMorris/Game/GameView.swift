import SwiftUI

struct GameView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        
        HStack{
            VStack {
                Text("Nine men's morris")
                    .font(.custom("Viking", size: 12.0))
                
                Text("Game phase \(viewModel.gamePhase())")
                
                Text("Current player: \(viewModel.currentPlayer())")
                Text("Player I men: \(viewModel.menLeft(player: .player1))")
                Text("Player II men: \(viewModel.menLeft(player: .player2))")
                
                Text("Can attack?: \(viewModel.canAttack() ? "Yes" : "No")")
                
                Spacer()
            }
            
            VStack {
                ZStack {
                    Image("oak")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: 400,
                                height: 400
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    GeometryReader { geometry in
                        let borderSize = geometry.size
                        
                        // Place grid
                        ForEach(viewModel.getEdges(), id: \.id) { edge in
                            let start = viewModel.getPointLocation(point: edge.vertex1, borderSize: borderSize)
                            let end = viewModel.getPointLocation(point: edge.vertex2, borderSize: borderSize)
                            
                            Path { path in
                                path.move(to: start)
                                path.addLine(to: end)
                            }
                            .stroke(Color.black, lineWidth: 3)
                        }
                        
                        // Place points on board
                        ForEach(viewModel.getPoints(), id: \.id) { point in
                            let location = viewModel.getPointLocation(point: point, borderSize: borderSize)
                            
                            Point(point: point, location: location, action: {viewModel.playerAction(at: point.id)})
                        }
                    }
                    .frame(width: 400, height: 400)
                    .shadow(radius: 0.5)
                }
            }
        }
    }
}

#Preview {
    GameView()
}
