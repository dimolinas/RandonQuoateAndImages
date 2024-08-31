//
//  WebService.swift
//  RamdonQuoateAndImages
//
//  Created by Diegoe012 on 27/08/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidImageId(Int)
    case decodingError
}

class WebService {
    
    static let shared: WebService = WebService()
    
    private init() {
        
    }
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        var randomImages : [RandomImage] = []
        
        try await withThrowingTaskGroup(of: (Int, RandomImage).self, body: { group in
            for id in ids {
                group.addTask { [self] in
                    return (id, try await getRandomImage(id: id))
                }
            }
            
            for try await(_, randomImage) in group {
                randomImages.append(randomImage)
            }
        })
        
        return randomImages
    }
    
    func getRandomImage(id: Int) async throws -> RandomImage {
        
        guard let url = Constants.Urls.getRandomImagesUrl() else { throw NetworkError.badUrl }
        guard let quoteUrl = Constants.Urls.randomQuoteUrl else { throw NetworkError.badUrl }
        
        async let (imageData, _) = try await URLSession.shared.data(from: url)
        async let (quoteDate, _) = try await URLSession.shared.data(from: quoteUrl)
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await quoteDate) else { throw NetworkError.decodingError }
        return RandomImage(image: try await imageData, quote: quote)
    }
}
