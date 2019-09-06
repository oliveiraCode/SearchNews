//
//  Articles.swift
//  SearchNews
//
//  Created by Leandro Fernandes De Oliveira on 2019-09-06.
//  Copyright © 2019 Leandro Oliveira. All rights reserved.
//

import Foundation

struct Articles:Codable {
    let url: String?
    let urlToImage: String?
    let source: Source?
}
