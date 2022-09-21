//
//  SearchViewModel.swift
//  MediaJust
//
//  Created by Reda on 15/09/2022.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
	func didReceiveResults(infos: MediaInfos)
}

struct SearchViewModel {
	
	weak var delegate: SearchViewModelDelegate?
	
	let categories = ["general",
					  "business",
					  "entertainment",
					  "health",
					  "science",
					  "sports",
					  "technology"]
	
	
	let countries = ["Belgique","France","Etats-Unis","Suéde","Suisse","Italie","Allemagne","Argentine"]
	
	var selectedCategory = ""
	var selectedCountry = ""
	var keywords = ""
	
	private let mediaService: MediaServiceProtocol
	
	init(mediaService: MediaServiceProtocol = MediaService.shared) {
		self.mediaService = mediaService
	}
	
	func getResult() {
		mediaService.getMedia(categories: selectedCategory, countries: selectedCountry, keyWords: keywords) { (info, success, error) in
			if let info {
				delegate?.didReceiveResults(infos: info)
			} else {
				// TODO: Display user friendly error
			}
		}
	}
}
