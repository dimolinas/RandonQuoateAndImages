//
//  RandomImage.swift
//  RamdonQuoateAndImages
//
//  Created by Diegoe012 on 27/08/24.
//

import Foundation

struct RandomImage : Decodable {
    let image : Data
    let quote : Quote
}

struct Quote : Decodable {
    let content: String 
}
