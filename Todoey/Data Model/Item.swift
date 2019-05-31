//
//  Item.swift
//  Todoey
//
//  Created by David Zywiec on 5/19/19.
//  Copyright © 2019 SirHowardGrubb. All rights reserved.
//

import Foundation

class Item: Codable {
    var title = ""
    var checked = false
    var created_date = Date.init()
    
    init(titleData : String) {
        title = titleData
    }
    
    
}
