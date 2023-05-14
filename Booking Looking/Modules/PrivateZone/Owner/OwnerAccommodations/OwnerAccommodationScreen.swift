//
//  OwnerAccommodationScreen.swift
//  Booking Looking
//
//  Created by Данила Парамин on 15.05.2023.
//

import SwiftUI

struct OwnerAccommodationScreen: View {
    let accommodations: [AccommodationSearchModel]

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(accommodations) { accommodation in

                        AccommodationCard(model: accommodation)
                    }
                }
                .padding()
            }
        }
    }

}





struct OwnerAccommodationScreen_Previews: PreviewProvider {
    static var previews: some View {
        OwnerAccommodationScreen(accommodations: [AccommodationSearchModel.mock(),
                                             AccommodationSearchModel.mock2()])
    }
}
