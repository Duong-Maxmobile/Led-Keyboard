//
//  ListGradientTheme.swift
//  Keyboard Customized 1
//
//  Created by Mac on 11/05/2022.
//

import Foundation
import SwiftUI

enum GradientFactory {
    case hot
    case cool
    
    func GradientLayer(_ viewHeight: CGFloat) -> LinearGradient {
        switch self {
        case .hot:
            return LinearGradient(
                gradient: Gradient(colors: self.getColors(viewHeight)),
                startPoint: UnitPoint(x: 0.5, y: 0.0),
                endPoint: UnitPoint(x: 0.5, y: 1.0))
        case .cool:
            return LinearGradient(
                gradient: Gradient(colors: self.getColors(viewHeight)),
                startPoint: UnitPoint(x: 0.5, y: 0.0),
                endPoint: UnitPoint(x: 0.5, y: 1.0))
        }
    }
    
    private func getColors(_ viewHeight: CGFloat) -> [Color] {
        let quantity: Int = Int((viewHeight / 100.0).rounded())
        switch self {
        case .hot:
            return generateColorList(quantity, colors: [.red, .yellow])
        case .cool:
            return generateColorList(quantity, colors: [.blue, .purple])
        }
    }
    
    private func generateColorList(_ quantity: Int, colors: [Color]) -> [Color] {
        guard !colors.isEmpty else {
            let defaultColors: [Color] = generateColorList(quantity, colors: [.green, .red])
            return defaultColors
        }
        var _result: [Color] = [Color]()
        while _result.count < quantity {
            _result.append(contentsOf: colors)
        }
        let _lastColor: Color = colors.last!
        _result.insert(_lastColor, at: 0)
        return _result
    }
}
