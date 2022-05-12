//
//  KeyboardViewController.swift
//  Keyboard Customized 1
//
//  Created by Mac on 10/05/2022.
//

import UIKit

class KeyboardViewController: KeyboardInputViewController {
    
    /**
     In this demo, we will configure KeyboardKit to use some
     demo-specific services.
     */
    override func viewDidLoad() {
        
        // Setup a fake, demo-specific autocomplete provider
        autocompleteProvider = FakeAutocompleteProvider()
        
        // Setup a demo-specific keyboard appearance
        // 💡 Play with this to change style of the keyboard
        keyboardAppearance = DemoKeyboardAppearance(context: keyboardContext)
        
        // Setup a demo-specific keyboard action handler
        // 💡 Play with this to change the keyboard behavior
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)
        
        // Setup a demo-specific keyboard layout provider
        // 💡 Play with this to change the keyboard's layout
        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
            inputSetProvider: inputSetProvider,
            dictationReplacement: nil)
        
        // Call super to perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated.
     
     Here, we call setup with a demo-specific view that uses
     ``SystemKeyboard`` to mimic a native iOS keyboard.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // Setup a demo-specific keyboard view
        setup(with: KeyboardView())
    }
}
