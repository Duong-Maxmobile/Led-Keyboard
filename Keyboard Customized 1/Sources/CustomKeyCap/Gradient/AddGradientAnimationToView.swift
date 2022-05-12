//
//  AddGradientAnimationToView.swift
//  Keyboard Customized 1
//
//  Created by Mac on 11/05/2022.
//

import SwiftUI

//struct AddGradientAnimationToKeyboard<Content: View>: View {
//    init(content: Content) {
//        self.KeyboardView = content
//    }
//
//    private let KeyboardView: Content
//
//    var body: some View {
//        KeyboardView
//    }
//}

struct GradientView: View {
    init(width: CGFloat, height: CGFloat) {
        self.ContainerViewWidth = width
        self.ContainerViewHeight = height
    }
    
    private let ContainerViewWidth: CGFloat
    private let ContainerViewHeight: CGFloat
    
    var body: some View {
        let _gradientViewHeight: CGFloat = self.ContainerViewHeight * 10
        GradientFactory.hot.GradientLayer(_gradientViewHeight)
            .frame(
                width: self.ContainerViewWidth,
                height: _gradientViewHeight,
                alignment: .center
            )
    }
}
