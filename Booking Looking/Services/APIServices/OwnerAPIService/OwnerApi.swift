//
//  OwnerApi.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 17.05.2023.
//

import Foundation
import Moya

enum OwnerApi {
    case ownerDetail(id: Int)
    case ownerAccommodation(id: Int)
}

extension OwnerApi: TargetType {
    var path: String {
        switch self {
        case .ownerDetail(let id):
            return "/owner-detail/\(id)/"
        case .ownerAccommodation(let id):
            return "/owner-accommodation/\(id)/"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Token \(LocalStorage.current.token)"]
    }
}
