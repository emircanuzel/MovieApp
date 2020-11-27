//
//  PopularMovieModel.swift
//  MovieApp
//
//  Created by Emircan UZEL on 25.11.2020.
//

import Foundation


struct PopularMovieModel : Codable {
    let results : [Results]?
    let total_results : Int?
    let page : Int?
    let total_pages : Int?
}


struct Results : Codable {
    let title : String?
    let video : Bool?
    let vote_average : Double?
    let id : Int?
    let overview : String?
    let release_date : String?
    let popularity : Double?
    let adult : Bool?
    let backdrop_path : String?
    let vote_count : Int?
    let genre_ids : [Int]?
    let poster_path : String?
    let original_language : String?
    let original_title : String?
    //    let poster_path : String?
    //    let popularity : Int?
    //    let id : Int?
    //    let overview : String?
    //    let backdrop_path : String?
    //    let vote_average : Int?
    let media_type : String?
    let first_air_date : String?
    let origin_country : [String]?
    //    let genre_ids : [String]?
    //    let original_language : String?
    //    let vote_count : Int?
    let name : String?
    let original_name : String?
    
    
}
