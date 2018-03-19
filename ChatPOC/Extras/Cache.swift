//
//  Cache.swift
//
//
//  Created by Developer on 08/08/17.
//  Copyright © 2017 Developer. All rights reserved.
//
import UIKit

class Cache {
    
    
    static let shared : NSCache<AnyObject,UIImage> = {
        
        return NSCache<AnyObject,UIImage>()
        
    }()
    
    
    class func image(forUrl : String?, completion : @escaping (UIImage?)-> ()){
        
        DispatchQueue.global(qos: .background).async {  // Retrieve the image in Background
            
            var image : UIImage? = nil
            
            guard  let url = forUrl else {
                completion(image)
                return
            }
            
            
            image = Cache.shared.object(forKey: url as AnyObject) // Retrieve Image From cache If available
            
            if image == nil, !url.isEmpty, let _url = URL(string: url) {  // If Image is not available, then download
                
                do {
                    
                    let data = try Data(contentsOf: _url)
                    
                    guard let imageData = UIImage(data: data) else {
                        completion(image)
                        return
                    }
                    
                    Cache.shared.setObject(imageData, forKey: url as AnyObject)
                    completion(imageData) // return Image
                    return
                    
                }catch let error {
                    print("Image Cache Error : ",error.localizedDescription)
                    completion(image) // If error return nil
                    return
                }
                
                
            }
            
            completion(image)
            
            
        }
    }
    
    
}
