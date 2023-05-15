//
//  AccommodationModelMapper.swift
//  Booking Looking
//
//  Created by Дмитрий Пантелеев on 12.05.2023.
//

import Foundation

final class UserAccommodationModelMapper: BaseModelMapper<ServerUserBooking, AccommodationModel> {
    override func toLocal(serverEntity: ServerUserBooking) -> AccommodationModel {
        AccommodationModel(id: serverEntity.accommodationID,
                           booking_id: serverEntity.bookingID ?? -1,
                           type: serverEntity.type.orEmpty,
                           ownerId: serverEntity.ownerID ?? -1,
                           ownerName: serverEntity.ownerName.orEmpty,
                           imagePreview: serverEntity.imagePreview.orEmpty,
                           images: serverEntity.images.orEmpty,
                           price: serverEntity.price ?? -1,
                           bookingDates: DateModelMapper().toLocal(list: serverEntity.bookingDates),
                           address: serverEntity.address.orEmpty)
    }
}

final class DateModelMapper: BaseModelMapper<ServerDate, DateModel> {
    override func toLocal(serverEntity: ServerDate) -> DateModel {
        DateModel(month: serverEntity.month ?? -1,
                  year: serverEntity.year ?? -1,
                  dates: serverEntity.dates.orEmpty)
    }
}

final class AccommodationSearchMapper: BaseModelMapper<ServerSearchBooking, AccommodationSearchModel> {
    override func toLocal(serverEntity: ServerSearchBooking) -> AccommodationSearchModel {
        AccommodationSearchModel(id: serverEntity.id,
                                 type: serverEntity.type.orEmpty,
                                 ownerId: serverEntity.ownerId ?? -1,
                                 ownerName: serverEntity.ownerName.orEmpty,
                                 imagePreview: serverEntity.imagePreview.orEmpty,
                                 address: serverEntity.address.orEmpty,
                                 price: serverEntity.price ?? -1)
    }
}

final class AccommodationDetailMapper: BaseModelMapper<ServerDetailBooking, AccommodationDetailModel> {
    override func toLocal(serverEntity: ServerDetailBooking) -> AccommodationDetailModel {
        AccommodationDetailModel(id: serverEntity.id,
                                 address: serverEntity.address.orEmpty,
                                 description: serverEntity.description.orEmpty,
                                 imagePreview: serverEntity.imagePreview.orEmpty,
                                 images: toLocalImages(serverEntity.images),
                                 type: serverEntity.type.orEmpty,
                                 rooms: serverEntity.rooms ?? -1,
                                 beds: serverEntity.beds ?? -1,
                                 capacity: serverEntity.capacity ?? -1,
                                 ownerId: serverEntity.ownerId ?? -1,
                                 ownerName: serverEntity.ownerName.orEmpty,
                                 price: serverEntity.price ?? -1,
                                 cancellationPolicy: serverEntity.cancellationPolicy.orEmpty,
                                 freeDates: DateModelMapper().toLocal(list: serverEntity.freeDates))
    }
    
    func toLocalImages(_ images: [String:String]?) -> [String] {
        if let images {
            var imgs: [String] = []
            
            for item in images.values {
                imgs.append(item)
            }
            
            return imgs
        } else {
            return []
        }
    }
}
