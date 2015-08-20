//
//  Item.swift
//  FleaMarket
//
//  Created by RoryZhuang on 8/12/15.
//  Copyright (c) 2015 Rose-Hulman. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    
    var key : String
    var itemTitle : String
    var itemDes : String
    var itemDate : NSDate
    var itemType : String
    var itemOwner : String
    
    init(key: String, itemTitle : String, itemDes : String, itemDate : NSDate, itemOwner : String, itemType : String){
        self.key = key
        self.itemTitle = itemTitle
        self.itemDes = itemDes
        self.itemDate = itemDate
        self.itemOwner = itemOwner
        self.itemType = itemType
        
    }
    
}
