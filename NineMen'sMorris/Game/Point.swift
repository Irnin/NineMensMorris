import SwiftUI

struct Point: View {
    @State var point: Vertex
    @State var location: CGPoint
    
    var action: () -> Void
    
    var body: some View {
        
        Circle()
            .fill(point.getColor())
            .frame(width: 20)
            .position(location)
            .onTapGesture {
                action()
            }
    }
}
