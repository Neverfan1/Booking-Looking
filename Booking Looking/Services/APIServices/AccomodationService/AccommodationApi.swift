//
//  AccommodationApi.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation
import Moya
import CombineMoya

enum AccommodationApi {
    case filter(type: Int?, rooms: Int?, beds: Int?, capacity: Int?, priceTo: Int?, priceFrom: Int?, offset: Int, count: Int)
    case detail(id: Int)
}

extension AccommodationApi: TargetType {
    var path: String {
        switch self {
        case .filter:
            return "accommodation-filter"
        case .detail(let id):
            return "accommodation-detail/\(id)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .filter(let type, let rooms, let beds, let capacity, let priceTo, let priceFrom, let offset, let count):
            var params: [String:Any] = [:]
            if let type = type {
                params["type"] = type
            }
            if let type = type {
                params["rooms"] = rooms
            }
            if let type = type {
                params["beds"] = beds
            }
            if let type = type {
                params["capacity"] = capacity
            }
            if let type = type {
                params["priceTo"] = priceTo
            }
            if let type = type {
                params["priceFrom"] = priceFrom
            }
            params["offset"] = offset
            params["count"] = count
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        default: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
