//
//  AppButton.swift
//  Booking Looking
//
//  Created by Данила Парамин on 21.04.2023.
//

import Foundation
import SwiftUI

enum AppButtonStyle {
    case standart
    case exit
    
    var background: Color {
        switch self {
        case .standart: return Color.black
        case .exit: return Color.red
        }
    }
    
    var textColor: Color {
        switch self {
        case .standart: return Color.white
        case .exit: return Color.white
        }
    }
    
    var borderColor: Color {
        switch self {
        case .standart: return Color.white.opacity(0.2)
        case .exit: return Color.red
        }
    }
}
