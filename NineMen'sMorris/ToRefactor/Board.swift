import SwiftUI
import Foundation

struct Board: View {
    
//    @ObservedObject var todoListManager: TodoListManager
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let geometryCenterX = geometry.size.width / 2
            let geometryCenterY = geometry.size.height / 2
            
            ZStack {
                
                // board background
                Image("oak")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: min(geometry.size.width, 700),
                            height: min(geometry.size.height, 700)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .position(
                            x: geometryCenterX,
                            y: geometryCenterY
                        )
                
                //Board Lines
//                Line(StartX: -300, StartY: -300, EndX: +300, EndY: -300)
//                Line(StartX: -300, StartY: +300, EndX: +300, EndY: +300)
//                Line(StartX: +300, StartY: +300, EndX: +300, EndY: -300)
//                Line(StartX: -300, StartY: -300, EndX: -300, EndY: +300)
//                
//                Line(StartX: -200, StartY: -200, EndX: +200, EndY: -200)
//                Line(StartX: -200, StartY: +200, EndX: +200, EndY: +200)
//                Line(StartX: +200, StartY: +200, EndX: +200, EndY: -200)
//                Line(StartX: -200, StartY: -200, EndX: -200, EndY: +200)
//                
//                Line(StartX: -100, StartY: -100, EndX: +100, EndY: -100)
//                Line(StartX: -100, StartY: +100, EndX: +100, EndY: +100)
//                Line(StartX: +100, StartY: +100, EndX: +100, EndY: -100)
//                Line(StartX: -100, StartY: -100, EndX: -100, EndY: +100)
//                
//                Line(StartX: 0, StartY: -300, EndX: 0, EndY: -100)
//                Line(StartX: 0, StartY: +300, EndX: 0, EndY: +100)
//                Line(StartX: -300, StartY: 0, EndX: -100, EndY: 0)
//                Line(StartX: 300, StartY: 0, EndX: 100, EndY: 0)
                
                // Board Fields
//                Field(state: .available, positionX: 0, positionY: -300, action: {})
//                Field(state: .available, positionX: 0, positionY: -200, action: {})
//                Field(state: .available, positionX: 0, positionY: -100, action: {})
//
//                Field(state: .available, positionX: 0, positionY: +300, action: {})
//                Field(state: .available, positionX: 0, positionY: +200, action: {})
//                Field(state: .available, positionX: 0, positionY: +100, action: {})
//                
//                Field(state: .available, positionX: -300, positionY: 0, action: {})
//                Field(state: .available, positionX: -200, positionY: 0, action: {})
//                Field(state: .available, positionX: -100, positionY: 0, action: {})
//                
//                Field(state: .available, positionX: +300, positionY: 0, action: {})
//                Field(state: .available, positionX: +200, positionY: 0, action: {})
//                Field(state: .available, positionX: +100, positionY: 0, action: {})
//                
//                Field(state: .available, positionX: +100, positionY: +100, action: {})
//                Field(state: .available, positionX: +100, positionY: -100, action: {})
//                Field(state: .available, positionX: -100, positionY: -100, action: {})
//                Field(state: .available, positionX: -100, positionY: +100, action: {})
//                
//                Field(state: .available, positionX: +200, positionY: +200, action: {})
//                Field(state: .available, positionX: +200, positionY: -200, action: {})
//                Field(state: .available, positionX: -200, positionY: -200, action: {})
//                Field(state: .available, positionX: -200, positionY: +200, action: {})
//                
//                Field(state: .available, positionX: +300, positionY: +300, action: {})
//                Field(state: .available, positionX: +300, positionY: -300, action: {})
//                Field(state: .available, positionX: -300, positionY: -300, action: {})
//                Field(state: .available, positionX: -300, positionY: +300, action: {})
            }
        }
    }
}

//#Preview {
//    var todoListManager = TodoListManager()
//    ToDoListView(todoListManager: todoListManager)
//}
