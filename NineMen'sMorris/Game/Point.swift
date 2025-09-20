//
//  Point.swift
//  NineMen'sMorris
//
//  Created by Łukasz Michalak on 19/09/2025.
//

import SwiftUI

struct Point: View {
    var body: some View {
        Button(action: {
            print("Round Action")
            }) {
            Text("")
                .frame(width: 100, height: 100)
                .foregroundColor(Color.black)
                .background(Color.red)
                .clipShape(Circle())
        }
    }
}

#Preview {
    Point()
}
