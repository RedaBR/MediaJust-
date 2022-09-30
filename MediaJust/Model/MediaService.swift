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
    
    
    
    //    https://api.mediastack.com/v1/news?news&access_key=429ff5d9ffd8662bd2ed4fa813a07040&keywords=tennis&categories=business
    let baseUrl = "https://api.mediastack.com/v1/news?news&access_key=429ff5d9ffd8662bd2ed4fa813a07040"
    
    func getMedia (categories:String,keyWords:String, callBack : @escaping (MediaInfos?,Bool,Error?)->Void) {
        let url = getUrl(categories: categories, keyWords: keyWords)
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
    
    func getUrl (categories:String, keyWords:String)->URL {
        let originalUrl = baseUrl + "&keywords=" + keyWords + "&categories=" + categories
        let urlString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        return url!
    }
}
