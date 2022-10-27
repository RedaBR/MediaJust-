//
//  Media.swift
//  MediaJust
//
//  Created by Reda on 07/07/2022.
//

import Foundation

class MediaService {
// MARK: - Initialisation for network call and response management
    private init() {}
    static let shared = MediaService()
    var session = URLSession.shared
    init(session: URLSession) {
        self.session = session
    }
// MARK: - Network call
// Managements of url for get element to change
// url https://api.mediastack.com/v1/news?news&access_key=429ff5d9ffd8662bd2ed4fa813a07040&keywords=tennis&categories=business
    let baseUrl = "https://api.mediastack.com/v1/news?access_key=429ff5d9ffd8662bd2ed4fa813a07040"
    // function for netwotk call
    func getMedia (categories: String, languages: String, keyWords: String, callBack : @escaping (MediaInfos?, Bool, Error?) -> Void) {
        let url = getUrl(categories: categories, languages: languages, keyWords: keyWords)
        // request with url
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Management response of nerwork call
        session.dataTask(with: request) { (data, _, error) in
        // asynchronous functions in threads
            DispatchQueue.main.async {
                if let data = data, error == nil {
           do { let responseJson = try JSONDecoder().decode(MediaInfos.self, from: data)
            callBack(responseJson, true, nil)
            }
                    catch {callBack(nil, false, error)}
                                                  }
            }
        }
        // execute task
        .resume()
    }
    // MARK: - Url Management
    // URL gathering
    func getUrl (categories: String, languages: String, keyWords: String) -> URL {
        let originalUrl = baseUrl + "&keywords=" + keyWords + "&languages=" + languages + "&categories=" + categories
        let urlString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        return url!
    }
}
