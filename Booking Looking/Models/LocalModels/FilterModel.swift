//
//  FilterModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 29.04.2023.
//

import Foundation

struct Filter {
    var type: String?
    var rooms: Int?
    var beds: Int?
    var capacity: Int?
    var priceTo: Int?
    var priceFrom: Int?
    
    static var empty: Filter {
        Filter(type: nil,
               rooms: nil,
               beds: nil,
               capacity: nil,
               priceTo: nil,
               priceFrom: nil)
    }
}

