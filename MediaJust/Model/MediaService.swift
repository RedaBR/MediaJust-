//
//  Media.swift
//  MediaJust
//
//  Created by Reda on 07/07/2022.
//

import Foundation
class MediaService {
    
    private init() {}
    
    static let shared = MediaService()
    var session = URLSession.shared
   
    
   
//    https://api.mediastack.com/v1/news?news&access_key=429ff5d9ffd8662bd2ed4fa813a07040&keywords=tennis&countries=us&sources=business
    let baseUrl = "https://api.mediastack.com/v1/news?news&access_key=429ff5d9ffd8662bd2ed4fa813a07040"
    
    func getMedia (categories:String, countries:String, keyWords:String, callBack : @escaping (MediaInfos?,Bool,Error?)->Void) {
        let url = getUrl(categories: categories, countries: countries, keyWords: keyWords)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
       session.dataTask(with: request){ (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    do { let responseJson = try JSONDecoder().decode(MediaInfos.self,from: data)
                        callBack(responseJson,true, nil)
                        }
                    catch {callBack(nil,false,error)}
                } 
            }
                    }
       .resume()

  }
    
    func getUrl (categories:String, countries:String, keyWords:String)->URL {
        let originalUrl = baseUrl + "&keywords=" + keyWords + "&countries=" + countries + "&sources=" + categories
        let url = URL(string: originalUrl)
        return url!
    }
}
