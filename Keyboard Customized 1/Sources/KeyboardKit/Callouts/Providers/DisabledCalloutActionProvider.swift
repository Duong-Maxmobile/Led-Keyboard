//
//  DisabledCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-10-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This provider can be used to disable callout actions.
 */
class DisabledCalloutActionProvider: CalloutActionProvider {
    
    func calloutActions(for action: KeyboardAction) -> [KeyboardAction] { [] }
}
