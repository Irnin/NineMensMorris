import SwiftUI

struct GameView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        
        VStack{
            ZStack {
                Image("oak")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: 800,
                            height: 800
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                
                GeometryReader { geometry in
                    ForEach(viewModel.getEdges(), id: \.id) { edge in
                        let start = edge.verticle1.position
                        let end = edge.verticle2.position
                        
                        Path { path in
                            path.move(to: start)
                            path.addLine(to: end)
                        }
                        .stroke(Color.black, lineWidth: 3)
                    }
                    
                    
                    ForEach(viewModel.getPoints(), id: \.id) { point in
                        Circle()
                            .fill(.black)
                            .frame(width: 20)
                            .position(point.position)
                            .onTapGesture {
                                print(point.id)
                            }
                    }
                }
                .frame(width: 800, height: 800)
                .shadow(radius: 0.5)
            }
        }
    }
}

#Preview {
    GameView()
}
