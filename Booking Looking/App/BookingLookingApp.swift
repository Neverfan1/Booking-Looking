//
//  Booking_LookingApp.swift
//  Booking Looking
//
//  Created by Данила Парамин on 20.04.2023.
//

import SwiftUI

@main
struct Booking_LookingApp: App {
    var body: some Scene {
        WindowGroup {
//            SearchAccommodation(accommodations: [AccommodationModel(id: 1,
//                                                                  address: "Test Address",
//                                                                  description: "test description",
//                                                                  image_preview: "https://www.only-remontkvartir.ru/upload/iblock/29a/29a4d01f9562c66633757f0a921b56c2.jpg",
//                                                                  images: ["https://if.cdnstroy.ru/fveqh3lncrbw5_1cqwhsl/top-10-neudachnyh-planirovok-kvartir-v-novostroykah-foto-1.jpeg"],
//                                                                  type: "Kvartira",
//                                                                  rooms: 2,
//                                                                  beds: 2,
//                                                                  capacity: 2,
//                                                                  owner_id: 2,
//                                                                  owner_name: "Tester",
//                                                                  price: 4000,
//                                                                  cancellation_policy: "za den'", free_dates: [DateResponse(month: 5, year: 2023, dates: [1,2,3,4,5,6,7])]),
//                                               AccommodationModel(id: 2, address: "Test Address", description: "test description", image_preview: "https://s0.rbk.ru/v6_top_pics/media/img/8/01/755978177402018.jpg", images: ["https://if.cdnstroy.ru/fveqh3lncrbw5_1cqwhsl/top-10-neudachnyh-planirovok-kvartir-v-novostroykah-foto-1.jpeg"], type: "хата", rooms: 2, beds: 2, capacity: 2, owner_id: 2, owner_name: "Tester", price: 7000, cancellation_policy: "za den'", free_dates: [DateResponse(month: 6, year: 2023, dates: [1,2,3,4,5,6,7])]),
//                                               AccommodationModel(id: 3, address: "Test Address", description: "test description", image_preview: "https://evdom.ru/wp-content/uploads/2018/10/sovremennyj-dizajn-odnokomnatnoj-kvartiry-01-1000x750.jpg", images: ["https://if.cdnstroy.ru/fveqh3lncrbw5_1cqwhsl/top-10-neudachnyh-planirovok-kvartir-v-novostroykah-foto-1.jpeg"], type: "хата2", rooms: 2, beds: 2, capacity: 2, owner_id: 2, owner_name: "Tester", price: 9000, cancellation_policy: "za den'", free_dates: [DateResponse(month: 7, year: 2023, dates: [1,2,3,4,5,6,7])]),
//                                               AccommodationModel(id: 4, address: "Test Address", description: "test description", image_preview: "https://www.only-remontkvartir.ru/upload/iblock/29a/29a4d01f9562c66633757f0a921b56c2.jpg", images: ["https://if.cdnstroy.ru/fveqh3lncrbw5_1cqwhsl/top-10-neudachnyh-planirovok-kvartir-v-novostroykah-foto-1.jpeg"], type: "Kvartira", rooms: 2, beds: 2, capacity: 2, owner_id: 2, owner_name: "Tester", price: 1000, cancellation_policy: "za den'", free_dates: [DateResponse(month: 7, year: 2023, dates: [1,2,3,4,5,6,7])])
//                                              ])
            BookingView( freeDates: [DateResponse(month: 5, year: 2023, dates: [1,2,3,4,5,6,7]),
                                     DateResponse(month: 6, year: 2023, dates: [4,7,9,10,11,12,13,14,20,26,27,28]),
                                     DateResponse(month: 7, year: 2023, dates: [17,19,20,21,22,23,24,25,26,30])], onBooking: {}
                         )
                .preferredColorScheme(.light)
        }
    }
    
}
