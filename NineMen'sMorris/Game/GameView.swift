import SwiftUI

struct GameView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let geometryCenterX = geometry.size.width / 2
            let geometryCenterY = geometry.size.height / 2
            
            let geometryStartX = geometryCenterX - 400
            let geometryStartY = geometryCenterY - 400
            
            ZStack {
                Image("oak")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: min(geometry.size.width, 800),
                            height: min(geometry.size.height, 800)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .position(
                            x: geometryCenterX,
                            y: geometryCenterY
                        )
                
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
            
        }
    }
}

#Preview {
    GameView()
}
