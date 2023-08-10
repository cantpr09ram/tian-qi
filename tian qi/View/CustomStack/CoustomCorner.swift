//
//  CoustomCorner.swift
//  tian qi
//
//  Created by bochain on 2023/8/2.
//

import SwiftUI

struct CoustomCorner: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
