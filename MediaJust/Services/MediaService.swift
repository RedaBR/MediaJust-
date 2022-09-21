//
//  Media.swift
//  MediaJust
//
//  Created by Reda on 07/07/2022.
//

import Foundation

protocol MediaServiceProtocol {
	func getMedia(categories: String, countries: String, keyWords: String, callBack: @escaping (MediaInfos?, Bool, MediaServiceError?) -> Void)
}

enum MediaServiceError: Error {
	case unknown
	case invalidResponse
	case emptyData
	case failedToDeserialize(serializationError: Error)
	case redirection
	case client
	case server
}

final class MediaService: MediaServiceProtocol {
	
    private init() {}
    
    static let shared = MediaService()
	
	private let apiKey = "d7f25d23dcaa6b21239fd7da4a498574"
	
	private var session = URLSession.shared
    
   // https://api.mediastack.com/v1/news?news&access_key=429ff5d9ffd8662bd2ed4fa813a07040&keywords=tennis&countries=us&sources=business
    private let baseUrl = "https://api.mediastack.com/v1"
    
    func getMedia(categories: String, countries: String, keyWords: String, callBack: @escaping (MediaInfos?, Bool, MediaServiceError?) -> Void) {
        let url = getUrl(categories: categories, countries: countries, keyWords: keyWords)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
		session.dataTask(with: request) { (data, response, error) in
			if let error {
				callBack(nil, false, .unknown)
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse else {
				callBack(nil, false, .invalidResponse)
				return
			}
			
			switch httpResponse.statusCode {
			case 200..<300:
				guard let data else {
					callBack(nil, false, .emptyData)
					return
				}
				
				do {
					let responseJson = try JSONDecoder().decode(MediaInfos.self, from: data)
					
					callBack(responseJson, true, nil)
				} catch {
					callBack(nil, false, .failedToDeserialize(serializationError: error))
				}
				
			case 300..<400:
				callBack(nil, false, .redirection)
				
			case 400..<500:
				callBack(nil, false, .client)
				
			case 500..<600:
				callBack(nil, false, .server)
				
			default:
				callBack(nil, false, nil)
			}
		}.resume()
  }
    
    func getUrl (categories:String, countries:String, keyWords:String) -> URL {
		guard var components = URLComponents(string: baseUrl) else {
			fatalError("Should never happen")
		}
		
		var queryItems = [URLQueryItem]()
		queryItems.append(URLQueryItem(name: "access_key", value: apiKey))
		queryItems.append(URLQueryItem(name: "categories", value: categories))
		queryItems.append(URLQueryItem(name: "countries", value: countries))
		queryItems.append(URLQueryItem(name: "keywords", value: keyWords))
		
		components.queryItems = queryItems
		
        return components.url!
    }
}
