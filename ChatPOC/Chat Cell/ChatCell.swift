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
    
    @IBOutlet private var labelCell : UILabel?
    
    @IBOutlet private var labelTime : UILabel!
    
    @IBOutlet private var imageViewStatus : UIImageView!
    
    @IBOutlet private var imageViewAttachment : UIImageView?
    
    @IBOutlet private var activityIndicator : UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
               
    }

    func setSender(values : ChatResponse) {
        
       self.set(values: values.response, isRecieved: false)
 
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
        
        if values?.type != Mime.text.rawValue {
            
            Cache.image(forUrl: values?.url, completion: { (image) in
                
                DispatchQueue.main.async {
                  //  self.activityIndicator?.stopAnimating()
                    if image != nil {
                        self.imageViewAttachment?.image = image
                    }else {
                        self.imageViewAttachment?.image = #imageLiteral(resourceName: "errorImage")
                    }
                }
                
            })
            
        } else {
            
            self.labelCell?.text = values?.text

        }
        
        self.labelCell?.textColor = isRecieved ? .black : .white
        self.viewCell.backgroundColor = isRecieved ? .white : .blue
        self.labelTime.text = Formatter.shared.relativePast(for: Date(timeIntervalSince1970: TimeInterval(values?.timeStamp ?? 0)))
        self.imageViewStatus.image = values?.read == MessageStatus.sent.rawValue ? #imageLiteral(resourceName: "sent") : #imageLiteral(resourceName: "read")
        self.layoutIfNeeded()
 
    }
    
    
    
    
    
}
