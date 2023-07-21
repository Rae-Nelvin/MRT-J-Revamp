//
//  LoadingAnimation.swift
//  MRT-J
//
//  Created by Eldrick Loe on 21/07/23.
//

import Foundation
import SwiftUI

struct CircleLoadingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 360)

        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        return path
    }
}
