//
//  AuthApi.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 10.05.2023.
//

import Foundation
import Moya

enum AuthApi {
    case authorization(email: String)
    case checkCode(user: Int, code: String)
    case registration(phone: String, surname: String, name: String, sex: Int, email: String)
}

extension AuthApi: TargetType {
    var baseURL: URL {
        URL(string: Consts.baseURL)!
    }
    
    var path: String {
        switch self {
        case .authorization:
            return "/auth/"
        case .checkCode:
            return "/check-code/"
        case .registration:
            return "/registration/"
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var task: Moya.Task {
        switch self {
        case .authorization(let email):
            var params: [String: Any] = [:]
            params["email"] = email
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .checkCode(let user, let code):
            var params: [String: Any] = [:]
            params["user_id"] = user
            params["code"] = code
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .registration(let phone, let surname, let name, let sex, let email):
            var params: [String: Any] = [:]
            params["phone_number"] = phone
            params["name"] = name
            params["surname"] = surname
            params["sex"] = sex
            params["email"] = email
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
