//
//  SwiftUIView.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/13.
//

import SwiftUI
import UIKit
import ImageSlideshow
struct SwiftUIView: View {
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        imgSlide()
    }
}
struct imgSlide: UIViewRepresentable {
    func makeUIView(context: Context) -> ImageSlideshow {
        let imgSlide = ImageSlideshow(frame: .zero)
        imgSlide.setImageInputs([ImageSource(image: UIImage(named: "meta1.jpg")!)])
        return imgSlide
    }

    func updateUIView(_ uiView: ImageSlideshow, context: Context) {
    }

    typealias UIViewType = ImageSlideshow

}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
