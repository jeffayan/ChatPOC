//
//  FirebaseConstants.swift
//  ChatPOC
//
//  Created by CSS on 06/03/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import Foundation

var currentUserId = 22

struct FirebaseConstants {
    
    static let main = FirebaseConstants()
    
    let dbBase = "BaseUrl"
    let storageBase = "storageBase"
    
    let reciever = "reciever"
    let timeStamp = "timeStamp"
    let sender = "sender"
    let read = "read"
    let type = "type"
    let text = "text"
    let url = "url"
    
}

// Message Status

enum MessageStatus : Int {
    
    case sent = 0
    case recieved = 2
    case read = 1
    
}



// Mime Type For Attachments

enum Mime : String {
    
    case text = "text"
    case video = "video"
    case image = "image"
    case audio = "audio"
    
    var contentType : String {
        
        switch self {
        case .image:
            return "image/png"
        default :
            return .Empty
            
        }
        
    }
    
    var ext : String {
        
        switch self {
        case .image:
            return ".png"
        
        case .audio :
            return ".mp4"
        
        case .video:
            return ".mp3"
        
        default:
            return .Empty
        }
        
    }
    
    
    
}
