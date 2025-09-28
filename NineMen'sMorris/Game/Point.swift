import SwiftUI

struct Point: View {
    @State var point: Vertex
    var action: () -> Void
    
    var body: some View {
        
        Circle()
            .fill(point.getColor())
            .frame(width: 20)
            .position(point.position)
            .onTapGesture {
                action()
            }
    }
}
