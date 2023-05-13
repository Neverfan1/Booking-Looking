//
//  UserApi.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation
import Moya

enum UserApi {
    case getDetail(id: Int)
    case getBooking
}

extension UserApi: TargetType {
    var path: String {
        switch self {
        case .getDetail(let id):
            return "/user-detail/\(id)"
        case .getBooking:
            return "/user-booking"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}
