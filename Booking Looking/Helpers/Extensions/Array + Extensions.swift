//
//  Array + Extensions.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation

extension Optional where Wrapped == Array<String> {
    var orEmpty: Wrapped {
        self ?? []
    }
}

extension Optional where Wrapped == Array<Int> {
    var orEmpty: Wrapped {
        self ?? []
    }
}
