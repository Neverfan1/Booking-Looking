//
//  APIError.swift
//  Booking Looking
//
//  Created by Данила Парамин on 20.04.2023.
//

import Foundation


enum APIError: Error {
    case DateError
    case TokenError
    case DoesNotExistID
    case DifferentCode
    case ObjectDoesNotExist
    case ValidationError
    case MultipleObjectsReturned
    case EmptyResultSet
    case ParseError
    case ValueError
    case IntegrityError
    case KeyError
    case TypeError
}
