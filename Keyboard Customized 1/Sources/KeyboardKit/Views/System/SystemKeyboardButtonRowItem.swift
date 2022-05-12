//
//  SystemKeyboardButtonRowItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view is meant to be used within a `SystemKeyboard` and
 will apply the frames and paddings to the view, to mitigate
 dead tap areas, as well the correct appearance, style, view
 gestures etc.
 */
public struct SystemKeyboardButtonRowItem<Content: View>: View {
    
    /**
     Create a system keyboard button row item.
     
     - Parameters:
       - content: The content view to use within the item.
       - item: The layout item to use within the item.
       - context: The keyboard context to which the item should apply.
       - keyboardWidth: The total width of the keyboard.
       - inputWidth: The input width within the keyboard.
       - appearance: The appearance to apply to the item.
       - actionHandler: The button style to apply.
     */
    public init(
        content: Content,
        item: KeyboardLayoutItem,
        context: KeyboardContext,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler) {
        self.content = content
        self.item = item
        self.context = context
        self.keyboardWidth = keyboardWidth
        self.inputWidth = inputWidth
        self.appearance = appearance
        self.actionHandler = actionHandler
    }
    
    private let content: Content
    private let item: KeyboardLayoutItem
    private var context: KeyboardContext
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let appearance: KeyboardAppearance
    private let actionHandler: KeyboardActionHandler
    
    @State private var isPressed = false
    private let uiscreen = UIScreen.main.bounds
    
    @State private var offsetY = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    public var body: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .named("duongEdited"))
            content
                .background(
                    GradientFactory.hot.GradientLayer(1000)
                        .frame(width: uiscreen.width * 10, height: uiscreen.height * 10, alignment: .center)
                        .offset(x: -frame.origin.x, y: -frame.origin.y + CGFloat(offsetY))
                )
        }
        .frame(maxWidth: .infinity)
        .frame(height: item.size.height - item.insets.top - item.insets.bottom)
        .frame(alignment: .center)
        .clipped()
        .rowItemWidth(for: item, totalWidth: keyboardWidth, referenceWidth: inputWidth)
        .systemKeyboardButtonStyle(buttonStyle)
        .padding(item.insets)
        .background(Color.clearInteractable)
        .keyboardGestures(
            for: item.action,
            context: context,
            actionHandler: actionHandler,
            isPressed: $isPressed)
        .localeContextMenu(
            for: item.action,
            context: context)
        .onReceive(timer, perform: { _ in
            let _offsetYPreview = offsetY + Int(50.0)
            if CGFloat(_offsetYPreview) > (uiscreen.height - 460) * 10 {
                offsetY = 0
            } else {
                withAnimation(.spring()) {
                    offsetY = _offsetYPreview
                }
            }
        })
    }
}

private extension SystemKeyboardButtonRowItem {
    
    var buttonStyle: KeyboardButtonStyle {
        appearance.buttonStyle(for: item.action, isPressed: isPressed)
    }
}

public extension View {
    
    /**
     Apply a locale context menu to the view if the provided
     action is `nextLocale`.
     */
    @ViewBuilder
    func localeContextMenu(for action: KeyboardAction, context: KeyboardContext) -> some View {
        #if os(iOS) || os(macOS) || os(watchOS)
        if action == .nextLocale {
            self.localeContextMenu(for: context)
        } else {
            self
        }
        #else
        self
        #endif
    }
    
    /**
     Apply a certain layout width to the view, in a way that
     works with the rot item composition above.
     */
    @ViewBuilder
    func rowItemWidth(for item: KeyboardLayoutItem, totalWidth: CGFloat, referenceWidth: CGFloat) -> some View {
        let insets = item.insets.leading + item.insets.trailing
        switch item.size.width {
        case .available: self.frame(maxWidth: .infinity)
        case .input: self.frame(width: referenceWidth - insets)
        case .inputPercentage(let percent): self.frame(width: percent * referenceWidth - insets)
        case .percentage(let percent): self.frame(width: percent * totalWidth - insets)
        case .points(let points): self.frame(width: points - insets)
        }
    }
}

struct SystemKeyboardButtonRowItem_Previews: PreviewProvider {
    
    static func previewItem(_ text: String, width: KeyboardLayoutItemWidth) -> some View {
        SystemKeyboardButtonRowItem(
            content: Text(text),
            item: KeyboardLayoutItem(
                action: .backspace,
                size: KeyboardLayoutItemSize(
                    width: width,
                    height: 100),
                insets: .horizontal(0, vertical: 0)),
            context: .preview,
            keyboardWidth: 320,
            inputWidth: 30,
            appearance: .preview,
            actionHandler: PreviewKeyboardActionHandler())
    }
    
    static var previews: some View {
        HStack {
            previewItem("1", width: .inputPercentage(0.5))
            previewItem("2", width: .input)
            previewItem("3", width: .available)
            previewItem("4", width: .percentage(0.1))
            previewItem("5", width: .points(10))
        }
    }
}
