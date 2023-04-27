//
//  ColorTheme.swift
//  Booking Looking
//
//  Created by Данила Парамин on 27.04.2023.
//

import SwiftUI

struct CustomColorSchemeKey: EnvironmentKey {
    static let defaultValue: ColorScheme = .light
}

extension EnvironmentValues {
    var customColorScheme: ColorScheme {
        get { self[CustomColorSchemeKey.self] }
        set { self[CustomColorSchemeKey.self] = newValue }
    }
}
