//
//  Constants.swift
//  RamdonQuoateAndImages
//
//  Created by Diegoe012 on 27/08/24.
//

import Foundation


struct Constants {
    struct Urls {
        static func getRandomImagesUrl() -> URL? {
            return URL(string: "https://picsum.photos/id/\(Int.random(in: 1...100))/200/300?uuid=\(UUID().uuidString)")
        }
        
        static let randomQuoteUrl: URL? = URL(string: "https://api.quotable.io/random")
    }
}
