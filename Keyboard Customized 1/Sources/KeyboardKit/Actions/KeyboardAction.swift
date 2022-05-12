//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines keyboard-specific actions that correspond
 to actions that can be found on various keyboards. Keyboard
 actions are fundamental building-blocks in the library.
 
 Keyboard actions can be bound to buttons and triggered with
 a ``KeyboardActionHandler``. Keyboard actions are also used
 to define keyboard layouts and provide a declarative way to
 express a layout without having to specify exactly how your
 actions will be executed.
 
 Many keyboard actions have standard behaviors, while others
 don't and require custom handling. To customize how actions
 are handled, you can implement a custom action handler
 */
public enum KeyboardAction: Codable, Equatable {
    
    /// Deletes text backwards when pressed and repeats that action until released.
    case backspace
    
    /**
     Inserts a text character when tapped.
     
     This case takes a `String` instead of `Character` since
     some keys send multiple characters when they are tapped.
     */
    case character(String)
    
    /// Inserts a text character when tapped, but should be rendered as empty space.
    case characterMargin(String)
    
    /// Represents a command (⌘) key.
    case command
    
    /// Represents a control (⌃) key.
    case control
    
    /// A custom action that you can handle in any way you want, using a custom action handler.
    case custom(named: String)
    
    /// Represents a dictation key.
    case dictation
    
    /// Dismisses the keyboard when tapped.
    case dismissKeyboard
    
    /// Inserts an emoji when tapped.
    case emoji(Emoji)
    
    /// Can be used to show a specific emoji category.
    case emojiCategory(EmojiCategory)
    
    /// Represents an escape (esc) key.
    case escape
    
    /// Represents a function (fn) key.
    case function
    
    /// Can be used to refer to an image asset.
    case image(description: String, keyboardImageName: String, imageName: String)
    
    /// Changes the keyboard type when tapped.
    case keyboardType(KeyboardType)
    
    /// Moves the cursor back one position when tapped.
    case moveCursorBackward
    
    /// Moves the cursor forward one position when tapped.
    case moveCursorForward
    
    /// Represents a new line (⏎) key that uses an arrow icon and not a return text.
    case newLine
    
    /// Represents a keyboard switcher (🌐) button and triggers the keyboard switch action when tapped or pressed.
    case nextKeyboard
    
    /// Triggers the locale switch action when tapped and pressed.
    case nextLocale
    
    /// A placeholder action that does nothing and should not be rendered.
    case none
    
    /// Represents an option (⌥) key.
    case option
    
    /// Represents a primary return button, e.g. `go`, `search` etc.
    case primary(PrimaryType)
    
    /// Represents a return (⏎) key that uses a return text and not an arrow icon.
    case `return`
    
    /// A custom action that can be used to e.g. show a settings screen.
    case settings
    
    /// Changes the keyboard type to `.alphabetic(.uppercased)` when tapped and `.capslocked` when double tapped.
    case shift(currentState: KeyboardCasing)
    
    /// Inserts a space when tapped.
    case space
    
    /// Can be used to refer to a system image (SF Symbol).
    case systemImage(description: String, keyboardImageName: String, imageName: String)
    
    /// Inserts a tab when tapped.
    case tab
}


// MARK: - Public Extensions

public extension KeyboardAction {
    
    /**
     This enum can be used together with ``primary(_:)``.
     
     Primary buttons are color accented buttons that trigger
     a submit action in the keyboard, just like ``return``.
     */
    enum PrimaryType: String, CaseIterable, Codable, Equatable, Identifiable {
        
        case done, go, newLine, ok, search
        
        /**
         The type's unique identifier.
         */
        public var id: String { rawValue }
    }
    
    /**
     Whether or not the action is a character action.
     
     Note that ``characterMargin(_:)`` is excluded, since it
     is only meant to be used in layouts.
     */
    var isCharacterAction: Bool {
        switch self {
        case .character: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is an input action, which are
     inserting content into the proxy.
     
     An input action button is rendered as a light button in
     native iOS keyboards.
     */
    var isInputAction: Bool {
        switch self {
        case .character: return true
        case .characterMargin: return true
        case .emoji: return true
        case .image: return true
        case .space: return true
        case .systemImage: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a ``primary(_:)`` action.
     
     A primary action button is a color accented button with
     the same effect as ``return`` in native iOS keyboards.
     */
    var isPrimaryAction: Bool {
        switch self {
        case .primary: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a ``shift(currentState:)``
     action.
     */
    var isShift: Bool {
        switch self {
        case .shift: return true
        default: return false
        }
    }
    
    
    /**
     Whether or not the action is a system action.
     
     An system action button is rendered as a dark button in
     native iOS keyboards.
     */
    var isSystemAction: Bool {
        switch self {
        case .backspace: return true
        case .command: return true
        case .control: return true
        case .dictation: return true
        case .dismissKeyboard: return true
        case .emojiCategory: return true
        case .escape: return true
        case .function: return true
        case .keyboardType: return true
        case .moveCursorBackward: return true
        case .moveCursorForward: return true
        case .newLine: return true
        case .nextKeyboard: return true
        case .nextLocale: return true
        case .option: return true
        case .return: return true
        case .shift: return true
        case .settings: return true
        case .tab: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is an uppercase shift.
     */
    var isUppercaseShift: Bool {
        switch self {
        case .shift(let state): return state.isUppercased
        default: return false
        }
    }
}
