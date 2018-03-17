//
//  TableViewCell.swift
//  ChatPOC
//
//  Created by CSS on 06/03/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet private var viewCell : UIView!
    
    @IBOutlet private var labelCell : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
               
    }

    func setSender(values : ChatResponse) {
        
       self.set(values: values.response, isRecieved: false)
        
//        let rect = self.labelCell.textRect(forBounds: CGRect(origin: .zero, size: CGSize(width: labelCell.bounds.width, height: .greatestFiniteMagnitude)), limitedToNumberOfLines: 0)
        
//        if rect.width<self.labelCell.frame.width{
//             self.viewCell.frame = CGRect(x: viewCell.frame.width-(rect.width+24), y: 0, width: (rect.width+24), height: viewCell.frame.height)
//             self.layoutIfNeeded()
//             print("--   Rect ",rect)

//       }
 
    }
    
    
    func setRecieved(values : ChatResponse){
       
        guard let entity = values.response , let key = values.key, let sender = entity.sender else {
            return
        }
       
        if entity.read == MessageStatus.sent.rawValue {
            entity.read = MessageStatus.read.rawValue
            FirebaseHelper.shared.update(chat: entity, key: key, toUser: sender)
        }
        
        self.set(values: values.response, isRecieved: true)
        
    }
    
    private func set(values : ChatEntity?, isRecieved : Bool){
        
        self.labelCell.text = values?.text
        self.labelCell.textColor = isRecieved ? .black : .white
        self.viewCell.backgroundColor = isRecieved ? .white : .blue
        
        self.layoutIfNeeded()

        
    }
    
    
    
    
    
}
