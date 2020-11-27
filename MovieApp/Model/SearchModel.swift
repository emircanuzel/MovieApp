//
//  SearchModel.swift
//  MovieApp
//
//  Created by Emircan UZEL on 26.11.2020.
//

import Foundation

struct SearchModel : Codable {
    let page : Int?
    let results : [Results]?
    let total_results : Int?
    let total_pages : Int?
}

struct SResults : Codable {
    let poster_path : String?
    let popularity : Int?
    let id : Int?
    let overview : String?
    let backdrop_path : String?
    let vote_average : Int?
    let media_type : String?
    let first_air_date : String?
    let origin_country : [String]?
    let genre_ids : [String]?
    let original_language : String?
    let vote_count : Int?
    let name : String?
    let original_name : String?
}
