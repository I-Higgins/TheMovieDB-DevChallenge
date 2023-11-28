//
//  HttpClient.swift
//  TMDB
//
//  Created by Isaac Higgins on 21/11/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidData
    case decodingError
    case invalidResponse
    case invalidToken
}

class PopularMoviesRequest: NSObject {
    let url: URL
    
    override init() {
        guard let url2 = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Keys.TheMovieDataBaseApiKey)") else {fatalError()}
        self.url = url2
    }
    
    func RetrieveMovies(completion: @escaping (Result<[MovieModel], NetworkError>) -> Void) {
        var request = URLRequest(url: self.url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
          do {
              let movies = try JSONDecoder().decode(MovieResponseModel.self, from: data)
              completion(.success(movies.results))
          } catch {
              completion(.failure(.decodingError))
          }
        }.resume()
    }
    
    func RetrieveMoviePoster(movieInfo: MovieModel, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w300\(movieInfo.poster_path ?? "")?api_key=\(Keys.TheMovieDataBaseApiKey)") else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
                completion(.success(data))
        }.resume()
    }
    
    func RetrieveMovieBackDrop(movieInfo: MovieModel, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w1280\(movieInfo.backdrop_path ?? "")?api_key=\(Keys.TheMovieDataBaseApiKey)")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
                completion(.success(data))
        }.resume()
    }
}
