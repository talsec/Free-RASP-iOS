//
//  ProtectionMeterArrowView.swift
//  FreeRASP Demo
//
//  Created by TalsecApp on 22/06/2021.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct ProtectionMeterArrowView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 150, height: 150, alignment: .center)
                .background(
                    Triangle()
                        .fill(Color(C.blueBlack.name))
                        .frame(width: 30, height: 25, alignment: .center)
                        .position(x: 75, y: 15)
                )
        }
    }
}

struct ProtectionMeterArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ProtectionMeterArrowView()
    }
}
