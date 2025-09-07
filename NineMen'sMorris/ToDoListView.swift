import SwiftUI
import Foundation

struct ToDoListView: View {
    
    @ObservedObject var todoListManager: TodoListManager
    
    var body: some View {
        VStack {
            
//            ZStack {
//                Image("oak")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 500, height: 500)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                    
//                    // Siatka - przezroczysta na wierzchu
//                    Image("grid")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit) // ← .fit zamiast .fill!
//                        .frame(width: 450, height: 450)
//                        .blendMode(.darken) // ← eksperymentuj z blend modes
//
//            }
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    ContentView()
//}
