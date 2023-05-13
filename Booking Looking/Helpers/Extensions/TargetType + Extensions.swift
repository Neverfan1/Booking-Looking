//
//  TargetType + Extensions.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        URL(string: Consts.baseURL)!
    }
}
