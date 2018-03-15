//
//  ChatEntity.swift
//  ChatPOC
//
//  Created by CSS on 06/03/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import Foundation

class ChatEntity : JSONSerializable {
    
    var sender : Int?
    var reciever : Int?
    var text : String?
    var url : String?
    var timeStamp : Int?
    var type : String?
    var read : Int?
    
    
}



