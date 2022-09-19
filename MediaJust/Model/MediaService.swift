//
//  Media.swift
//  MediaJust
//
//  Created by Reda on 07/07/2022.
//

import Foundation
class MediaService {
    
    private init() {}
    
    let shared = MediaService()
    var session = URLSession()
    var task = URLSessionTask()
    
   // https://api.mediastack.com/v1/news?news&access_key=429ff5d9ffd8662bd2ed4fa813a07040&keywords=tennis&countries=us&sources=business
    let baseUrl = "https://api.mediastack.com/v1?access_key=d7f25d23dcaa6b21239fd7da4a498574&"
    
    func getMedia (categories:String, countries:String, keyWords:String, callBack : @escaping (MediaInfos?,Bool,Error)->Void) {
        let url = getUrl(categories: categories, countries: countries, keyWords: keyWords)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data, error != nil {
                do { let responseJson = try JSONDecoder().decode(MediaInfos.self,from: data)
                    callBack(responseJson,true,error as! Error)
                    }
                catch {callBack(nil,false,error)}
            }
        })
  }
    
    func getUrl (categories:String, countries:String, keyWords:String)->URL {
        let originalUrl = baseUrl + "categories=" + categories + "&countries=" + countries + "&keywords=" + keyWords
        let url = URL(string: originalUrl)
        return url!
    }
}
