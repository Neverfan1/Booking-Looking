//
//  Provider.swift
//  Booking Looking
//
//  Created by Данила Парамин on 20.04.2023.
//

import Foundation
import Moya

final class Provider<P>: MoyaProvider<P> where P: TargetType {

    convenience init() {
        let endpointClosure = { (target: P) -> Endpoint in
            let defaultEndpointMapping = MoyaProvider
                .defaultEndpointMapping(for: target)
            
            return defaultEndpointMapping
        }
        let logger = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: [.formatRequestAscURL, .errorResponseBody, .verbose]))
        
        let plugins: [PluginType] = [logger]
        
        self.init(endpointClosure: endpointClosure,
                  plugins: plugins)
    }
}
