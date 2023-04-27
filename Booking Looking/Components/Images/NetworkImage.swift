//
//  NetworkImage.swift
//  Booking Looking
//
//  Created by Данила Парамин on 23.04.2023.
//

import SwiftUI
import Kingfisher

struct NetworkImage: SwiftUI.View {
    
    @State private var image: UIImage? = nil
    
    let imageURL: URL?
    
    var width: CGFloat?
    var height: CGFloat?
    var cornerRadius: CGFloat?
    
    
    init(imageURL: URL?,
         width: CGFloat?,
         height: CGFloat?,
         cornerRadius: CGFloat?) {
        self.imageURL = imageURL
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        
    }
    
    var body: some SwiftUI.View {
        Image(uiImage: image ?? UIImage(systemName: "eye.slash")!)
            .renderingMode(.original)
            .resizable()
            .frame(width: self.width ?? 43, height: self.height ?? 43)
            .cornerRadius(self.cornerRadius ?? 100)
            .onAppear{
                loadImage()
            }
    }
    
    
    
    private func loadImage() {
        guard let imageURL = imageURL, image == nil else { return }
        KingfisherManager.shared.retrieveImage(with: imageURL) { result in
            switch result {
            case .success(let imageResult):
                self.image = imageResult.image
            case .failure:
                break
            }
        }
    }
}
