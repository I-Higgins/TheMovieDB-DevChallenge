//
//  MovieModels.swift
//  TMDB
//
//  Created by Isaac Higgins on 21/11/23.
//

import Foundation
import UIKit

struct MovieResponseModel : Codable {
    var page: Int
    var results: [MovieModel]
    var total_pages: Int
    var total_results: Int
}

struct MovieModel : Codable, Identifiable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
    
    public func getReleaseYear() -> String {
        return String(self.release_date!.prefix(4))
    }
    
    public func getVotePercentage() -> String {
        return "\(String(Int((self.vote_average ?? 0) * 10)))"
    }
}

public struct MovieData: Codable {

    public var posterImage: Data = Data()
    public var backDropImage: Data = Data()
    var movieInfo: MovieModel = MovieModel()
    
    public func getPosterImage() -> UIImage {
        return UIImage(data: self.posterImage) ?? UIImage()
    }
    
    public func getBackDropImage() -> UIImage {
        return UIImage(data: self.backDropImage) ?? UIImage()
    }
}
