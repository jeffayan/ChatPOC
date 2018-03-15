//
//  FirebaseHelper.swift
//  ChatPOC
//
//  Created by CSS on 06/03/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage


typealias UploadTask = StorageUploadTask
typealias SnapShot = DataSnapshot

class FirebaseHelper{
    
   private var ref: DatabaseReference?
    
    private var storage : Storage?
 
   static var shared = FirebaseHelper()
    
    // Write Text Message
    
    func write(to userId : Int, with text : String){
        
        self.storeData(to: userId, with: text, mime: .text)
        
    }
    
    
    // Upload from data
    
    func write(to userId : Int, with data : Data, mime type : Mime, completion : @escaping (Bool)->())->UploadTask{
        
        let metadata = self.initializeStorage(with: type)
        
        return self.upload(data: data, mime: type, metadata: metadata, completion: { (url) in
            
            completion(url != nil)
            
            guard url != nil else {
                return
            }
            
            self.storeData(to: userId, with: url?.absoluteString, mime: type)
            
        })
        
    }
    
    
    // Upload from Filepath
    
    func write(to userId : Int, file url : URL, mime type : Mime, completion : @escaping (Bool)->())->UploadTask{
        
        let metadata = self.initializeStorage(with: type)
        
        return self.upload(file: url, mime: type, metadata: metadata, completion: { (url) in
            
            completion(url != nil)
            
            guard url != nil else {
                return
            }
            
            self.storeData(to: userId, with: url?.absoluteString, mime: type)
            
        })
        
        
    }
    
    // Update Message in Specific Path
    
    func update(message : String, key : String){
       
        
        
    }
    
    
    // Getting Chat Room Logic
    
    private func getRoom(forUser userId : Int)->String {
    
           return userId<currentUserId ? "\(userId)_\(currentUserId)":"\(currentUserId)_\(userId)"

    
    }
    
    
}


//MARK:- Helper Functions


extension FirebaseHelper {
    
    // Initializing DB
    
    private func initializeDB(){
        
        if ref == nil {
           let db = Database.database()
           db.isPersistenceEnabled = true
           self.ref = db.reference()
        }
        
    }
    
    // Initializing Storage
    
    private func initializeStorage(with type : Mime)->StorageMetadata{
        
        if self.storage == nil {
            self.storage = Storage.storage()
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = type.contentType
        
        return metadata
    }

    // Update Values in specific path
    
    private func update(chat : ChatEntity?, key : String?){
        
        guard let key = key, 
        
        
       // self.ref?.child(FirebaseConstants.main.dbBase).child(self.getRoom(forUser: userId)).updateChildValues(<#T##values: [AnyHashable : Any]##[AnyHashable : Any]#>)
        
    }
    
    
   
    // Common Function to Store Data
    
   private func storeData(to userId : Int, with string : String?, mime type : Mime){
    
        let chat = ChatEntity()
    
        chat.read = 0
        chat.reciever = currentUserId
        chat.sender = 10
        
    
        chat.timeStamp = Formatter.shared.removeDecimal(from: Date().timeIntervalSince1970)
        chat.type = type.rawValue
        
        if type == .text {
            
            chat.text = string
            
        } else {
            
            chat.url = string
            
        }
        
        
        self.initializeDB()
        self.ref?.child(FirebaseConstants.main.dbBase).child(self.getRoom(forUser: userId)).child(ref!.childByAutoId().key).setValue(chat.JSONRepresentation)
        
    }
    
    
    //MARK:- Upload Data to Storage Bucket
    
   private func upload(data : Data, mime : Mime, metadata : StorageMetadata, completion : @escaping (_  downloadUrl : URL?) -> ())->UploadTask{
       
       
        let uploadTask = self.storage?.reference(withPath: FirebaseConstants.main.storageBase).child(ProcessInfo().globallyUniqueString+mime.ext).putData(data, metadata: metadata, completion: { (metaData, error) in
            
            if error != nil, metaData == nil {
                
                print(" Error in uploading  ", error!.localizedDescription)
                
            } else {
                
                completion(metaData?.downloadURL())
                
            }
            
        })
        
        return uploadTask!
        
    }
    
    
    //MARK:- Upload File to Storage Bucket
    
   private func upload(file url : URL, mime : Mime, metadata : StorageMetadata, completion : @escaping (_  downloadUrl : URL?) -> ())->UploadTask{
      
     
        let uploadTask = self.storage?.reference(withPath: FirebaseConstants.main.storageBase).child(ProcessInfo().globallyUniqueString+mime.ext).putFile(from: url, metadata: metadata, completion: { (metaData, error) in
            
            if error != nil, metaData == nil {
                
                print(" Error in uploading  ", error!.localizedDescription)
                
                
            } else {
                
                completion(metaData?.downloadURL())
                
            }
            
            
        })
        
        return uploadTask!
    }
    
    
    
}


//MARK:- Observers


extension FirebaseHelper {
    
    // Observe if any value changes
    
    func observe(user id : Int, value : @escaping ([ChatResponse])->()) {
        
        self.initializeDB()
        
        self.ref?.child(FirebaseConstants.main.dbBase).child(getRoom(forUser: id)).queryLimited(toLast: 100).observe(.value, with: { (snapShot) in
            
            value(self.getModal(from: snapShot))
            
        })
        
    }
    
    
    // Get Values From SnapShot
    
    private func getModal(from snapShot : SnapShot)->[ChatResponse]{
        
        var chatArray = [ChatResponse]()
        var response : ChatResponse?
        var chat : ChatEntity?
        
        if let snaps = snapShot.valueInExportFormat() as? [String : NSDictionary] {
            
           for snap in snaps {
            
                 response = ChatResponse()
                 chat = ChatEntity()
            
                 response?.key = snap.key
            
        
                 chat?.read = snap.value.value(forKey: FirebaseConstants.main.read) as? Int
                 chat?.reciever = snap.value.value(forKey: FirebaseConstants.main.reciever) as? Int
                 chat?.sender = snap.value.value(forKey: FirebaseConstants.main.sender) as? Int
                 chat?.text = snap.value.value(forKey: FirebaseConstants.main.text) as? String
                 chat?.timeStamp = snap.value.value(forKey: FirebaseConstants.main.timeStamp) as? Int
                 chat?.type = snap.value.value(forKey: FirebaseConstants.main.type) as? String
                 chat?.url = snap.value.value(forKey: FirebaseConstants.main.type) as? String
            
                 chatArray.append(response!)
                
            }
        }
        return chatArray
    }
}


