//
//  AccommodationModel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import Foundation

struct AccommodationBookingModel:Identifiable{
    
    let id: Int
    let booking_id: Int
    let type:String
    let owner_id:Int
    let owner_name:String
    let image_preview:String
    let images:[String]
    let price:Int
    let booking_dates: [DateResponse]
    let address: String
    
}

struct AccommodationSearchModel: Identifiable{
    
    let id: Int
    let type:String
    let owner_id:Int
    let owner_name:String
    let image_preview:String
    let address:String
    let price:Int
}

struct AccommodationDetailModel: Identifiable{
    
    let id: Int
    let address:String
    let description:String
    let image_preview:String
    let images: [String]
    let type:String
    let rooms:Int
    let beds:Int
    let capacity:Int
    let owner_id:Int
    let owner_name:String
    let price:Int
    let cancellation_policy:String
    let free_dates: [DateResponse]
    
}



struct DateResponse: Identifiable, Hashable {
    let id = UUID()
    let month: Int
    let year: Int
    let dates: [Int]
}




extension AccommodationDetailModel{
    static func mock() -> Self {
        AccommodationDetailModel(id: 1,
                           address: "г. Саратов, ул. Пушника, д. 17в",
                           description: "Test Test Test Test Test Test Test Test Test TEst Test TEst Test ETst",
                           image_preview: "https://remont-f.ru/upload/iblock/597/dizayn-interyera-kvartiry-v-sovremennom-stile-gostinaja-2.jpg",
                           images: ["https://remont-f.ru/upload/iblock/597/dizayn-interyera-kvartiry-v-sovremennom-stile-gostinaja-2.jpg",
                                    "https://salon.ru/storage/thumbs/gallery/272/271492/835_3500_s927.jpg",
                                    "https://evdom.ru/wp-content/uploads/2018/10/sovremennyj-dizajn-odnokomnatnoj-kvartiry-01-1000x750.jpg",
                                    "https://exporealty.ru/upload/iblock/580/qiktucw85t4zl376ohcn99ev94iklgay/4.jpg",
                                    "https://novostroyki.shop/wp-content/uploads/2021/01/2250619.jpg",
                                    "https://darstroy-yug.ru/upload/medialibrary/571/5714b76c6608bb9e59d4bf4d2f03bb2d.jpg"],
                           type: "Комната",
                           rooms: 1,
                           beds: 1,
                           capacity: 2,
                           owner_id: 1,
                           owner_name: "test",
                           price: 4000,
                           cancellation_policy: "za den",
                           free_dates: [DateResponse(month: 5, year: 2023, dates: [1,2,3,4,5,6,7]),
                                        DateResponse(month: 6, year: 2023, dates: [12,13,14,15,20,21,22,23,27,28,29]),
                                        DateResponse(month: 7, year: 2023, dates: [5,6,7,8,9,14,15,16,19,20,21,22,23,24,25,26,27,28])]
        )
    }
}

extension AccommodationSearchModel{
    static func mock() -> Self {
        AccommodationSearchModel(id: 1,
                                 type: "Дом",
                                 owner_id: 1,
                                 owner_name: "Вася Пупкин",
                                 image_preview: "https://remont-f.ru/upload/iblock/597/dizayn-interyera-kvartiry-v-sovremennom-stile-gostinaja-2.jpg",
                                 address: "г. Саратов, ул. Пушника, д. 17в",
                                 price: 5000)
    }
    
    static func mock2() -> Self {
        AccommodationSearchModel(id: 2,
                                 type: "Квартрира",
                                 owner_id: 1,
                                 owner_name: "Лошадь",
                                 image_preview: "https://exporealty.ru/upload/iblock/580/qiktucw85t4zl376ohcn99ev94iklgay/4.jpg",
                                 address: "г. Энгельс, ул. Кравцов, д. 21б",
                                 price: 10000)
    }
}

extension AccommodationBookingModel{
    static func mock() -> Self {
        AccommodationBookingModel(id: 3,
                                  booking_id: 3,
                                  type: "Квартира",
                                  owner_id: 4,
                                  owner_name: "Михаил Кукуруза",
                                  image_preview:  "https://darstroy-yug.ru/upload/medialibrary/571/5714b76c6608bb9e59d4bf4d2f03bb2d.jpg",
                                  images: ["https://remont-f.ru/upload/iblock/597/dizayn-interyera-kvartiry-v-sovremennom-stile-gostinaja-2.jpg",
                                           "https://salon.ru/storage/thumbs/gallery/272/271492/835_3500_s927.jpg",
                                           "https://evdom.ru/wp-content/uploads/2018/10/sovremennyj-dizajn-odnokomnatnoj-kvartiry-01-1000x750.jpg",
                                           "https://exporealty.ru/upload/iblock/580/qiktucw85t4zl376ohcn99ev94iklgay/4.jpg",
                                           "https://novostroyki.shop/wp-content/uploads/2021/01/2250619.jpg",
                                           "https://darstroy-yug.ru/upload/medialibrary/571/5714b76c6608bb9e59d4bf4d2f03bb2d.jpg"],
                                  price: 7882,
                                  booking_dates:  [DateResponse(month: 10, year: 2023, dates: [1,2,3,4,5,6,7]),
                                                   DateResponse(month: 11, year: 2023, dates: [12,13,14,15,20,21,22,23,27,28,29]),
                                                   DateResponse(month: 12, year: 2023, dates: [5,6,7,8,9,14,15,16,19,20,21,22,23,24,25,26,27,28])],
                                  address: "Лермонтова 7А")
    }
}

