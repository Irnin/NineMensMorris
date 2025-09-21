//
//  Point.swift
//  NineMen'sMorris
//
//  Created by Łukasz Michalak on 19/09/2025.
//

import SwiftUI

struct Point: View {
    @State var point: Vertice
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
