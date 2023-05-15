//
//  ImageCarousel.swift
//  Booking Looking
//
//  Created by Данила Парамин on 03.05.2023.
//

import SwiftUI

struct ImageCarousel: View {
    
    let accommodationPhoto: [String]
    @State private var selectedImageIndex = 0
    
    var body: some View {
        VStack{
            TabView(selection: $selectedImageIndex) {
                ForEach(accommodationPhoto.indices, id: \.self) { index in
                    NetworkImage(imageURL: URL(string: accommodationPhoto[index]),
                                 width: UIScreen.main.bounds.width / 1.2,
                                 height: UIScreen.main.bounds.height / 4,
                                 cornerRadius: 10)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(height: 300)
            Divider()
        }

    }
}

struct ImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarousel(accommodationPhoto: ["https://remont-f.ru/upload/iblock/597/dizayn-interyera-kvartiry-v-sovremennom-stile-gostinaja-2.jpg",
                                                    "https://salon.ru/storage/thumbs/gallery/272/271492/835_3500_s927.jpg",
                                                    "https://evdom.ru/wp-content/uploads/2018/10/sovremennyj-dizajn-odnokomnatnoj-kvartiry-01-1000x750.jpg",
                                                    "https://exporealty.ru/upload/iblock/580/qiktucw85t4zl376ohcn99ev94iklgay/4.jpg",
                                                    "https://novostroyki.shop/wp-content/uploads/2021/01/2250619.jpg",
                                                    "https://darstroy-yug.ru/upload/medialibrary/571/5714b76c6608bb9e59d4bf4d2f03bb2d.jpg"])
    }
}
