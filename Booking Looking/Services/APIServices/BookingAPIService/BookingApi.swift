//
//  BookingApi.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation
import Moya

enum BookingApi {
    case postDate(dates: [[String:Any]], id: Int)
    case deleteDate(id: Int)
}

extension BookingApi: TargetType {
    var path: String {
        switch self {
        case .postDate:
            return "/booking-date/"
        case .deleteDate(let id):
            return "/cancel-booking-date/\(id)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postDate:
            return .post
        case .deleteDate:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postDate(let dates, let id):
            var params: [String:Any] = [:]
            params["booking_dates"] = dates
            params["accommodation_id"] = id
            return .requestCompositeParameters(bodyParameters: params,
                                               bodyEncoding: JSONEncoding.default,
                                               urlParameters: [:])
        case .deleteDate:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Token \(LocalStorage.current.token)"]
    }
    
    
}
