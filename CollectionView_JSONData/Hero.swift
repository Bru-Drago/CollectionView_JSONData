//
//  Hero.swift
//  CollectionView_JSONData
//
//  Created by Bruna Fernanda Drago on 26/05/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//

import Foundation

struct Hero:Decodable {
    
    var localized_name:String
    var img:String
    var icon:String
    var attack_range:Int
    var move_speed:Int
}
