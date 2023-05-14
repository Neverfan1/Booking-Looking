//
//  ProcessingState.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 14.05.2023.
//

import Foundation

enum ProcessingState {
    case loading
    case loaded
    case error(message: String)
}
