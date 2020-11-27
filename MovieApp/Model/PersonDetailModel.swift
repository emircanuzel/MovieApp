//
//  PersonDetailModel.swift
//  MovieApp
//
//  Created by Emircan UZEL on 27.11.2020.
//

import Foundation

struct PersonDetailModel : Codable {
    let adult : Bool?
    let also_known_as : [String]?
    let biography : String?
    let birthday : String?
    let deathday : String?
    let gender : Int?
    let homepage : String?
    let id : Int?
    let imdb_id : String?
    let known_for_department : String?
    let name : String?
    let place_of_birth : String?
    let popularity : Double?
    let profile_path : String?
}
