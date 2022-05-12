//
//  DeviceSpecificInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol extends `InputSetProvider` and can be used by
 any provider that bases its input set on the current device.
 
 For now, this provider will return the iPhone input set for
 any device that is not explicitly iPad.
 */
public protocol DeviceSpecificInputSetProvider: InputSetProvider {}

public extension DeviceSpecificInputSetProvider {
    
    /**
     Create an input row from phone and pad-specific strings.
     */
    func row(
        phone: String,
        pad: String,
        deviceType: DeviceType = .current) -> InputSetRow {
        InputSetRow(deviceType == .pad ? pad.chars : phone.chars)
    }
    
    /**
     Create an input row from phone and pad-specific arrays.
     */
    func row(
        phone: [String],
        pad: [String],
        deviceType: DeviceType = .current) -> InputSetRow {
        InputSetRow(deviceType == .pad ? pad : phone)
    }
    
    /**
     Create an input row from phone and pad-specific strings.
     */
    func row(
        phoneLowercased: String,
        phoneUppercased: String,
        padLowercased: String,
        padUppercased: String,
        deviceType: DeviceType = .current) -> InputSetRow {
        InputSetRow(
            lowercased: deviceType == .pad ? padLowercased.chars : phoneLowercased.chars,
            uppercased: deviceType == .pad ? padUppercased.chars : phoneUppercased.chars)
    }
    
    /**
     Create an input row from phone and pad-specific arrays.
     */
    func row(
        phoneLowercased: [String],
        phoneUppercased: [String],
        padLowercased: [String],
        padUppercased: [String],
        deviceType: DeviceType = .current) -> InputSetRow {
        InputSetRow(
            lowercased: deviceType == .pad ? padLowercased : phoneLowercased,
            uppercased: deviceType == .pad ? padUppercased : phoneUppercased)
    }
}
