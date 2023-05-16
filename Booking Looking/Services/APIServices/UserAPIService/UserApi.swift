//
//  UserApi.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation
import Moya

enum UserApi {
    case getDetail
    case getBooking
}

extension UserApi: TargetType {
    var path: String {
        switch self {
        case .getDetail:
            return "/user-detail/"
        case .getBooking:
            return "/user-booking/"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        ["Authorization": "Token \(LocalStorage.current.token)"]
    }
}
