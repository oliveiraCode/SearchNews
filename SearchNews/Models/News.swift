//
//  News.swift
//  SearchNews
//
//  Created by Leandro Fernandes De Oliveira on 2019-09-06.
//  Copyright © 2019 Leandro Oliveira. All rights reserved.
//

import Foundation

struct News:Codable {
    let status:String?
    let totalResults:Int?
    let articles:[Articles]
}
