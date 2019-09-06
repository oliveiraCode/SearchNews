//
//  Extensions.swift
//  SearchNews
//
//  Created by Leandro Fernandes De Oliveira on 2019-09-06.
//  Copyright © 2019 Leandro Oliveira. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setBorder(borderWidth:CGFloat, borderColor:UIColor){
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    func setRadius(cornerRadius:CGFloat, maskToBounds:Bool){
        layer.masksToBounds = maskToBounds
        layer.cornerRadius = cornerRadius
    }
}

extension String {
    func addPercentEncodingURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
