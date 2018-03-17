
//
//  ViewController.swift
//  ChatPOC
//
//  Created by CSS on 05/03/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import UIKit
import ImagePicker

class SingleChatController: UIViewController {
    
    
    @IBOutlet private var tableView : UITableView!
    @IBOutlet private var bottomConstraint : NSLayoutConstraint!
    @IBOutlet private var textViewSingleChat : UITextView!

    @IBOutlet private weak var viewCamera : UIView!
    @IBOutlet private weak var viewRecord : UIView!
    @IBOutlet private weak var viewSend : UIView!
    
    
    private let senderCellId = "sender"
    private let recieverCellId = "reciever"
    
    private var datasource = [ChatResponse]()
    
    
    private var isSendShown = false {
        
        didSet {
            
            self.viewCamera.isHidden = isSendShown
            self.viewSend.isHidden = !isSendShown
            self.viewRecord.isHidden = isSendShown
            
        }
        
    }
    
    
 
}



extension SingleChatController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    
    //MARK:- Initial Loads
    
    private func initialLoads(){
        
        let backButtonArrow = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow"), style: .plain, target: self, action: #selector(self.backButtonAction))
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        let imageButton = UIBarButtonItem(image: #imageLiteral(resourceName: "dp"), style: .plain, target: self, action: #selector(self.imageButtonAction))
        
        self.navigationItem.leftBarButtonItems = [backButtonArrow,fixedSpace,imageButton]
        
        self.navigationItem.title = "Adam"
        
        let callButton = UIBarButtonItem(image: #imageLiteral(resourceName: "call_icon"), style: .plain, target: self, action: #selector(self.callButtonAction))
        let videoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "video_icon"), style: .plain, target: self, action: #selector(self.videoButtonAction))
        let moreButton  = UIBarButtonItem(image: #imageLiteral(resourceName: "moreIcon"), style: .plain, target: self, action: #selector(self.moreButtonAction))
        
        self.navigationItem.rightBarButtonItems = [moreButton,videoButton,callButton]
        
        self.addKeyBoardObserver(with: bottomConstraint)
        
        self.tableView.register(UINib(nibName: XIB.Names.ChatSender, bundle: .main), forCellReuseIdentifier: senderCellId)
        self.tableView.register(UINib(nibName: XIB.Names.ChatReciever, bundle: .main), forCellReuseIdentifier: recieverCellId)
       // self.setEmptyView()
        
       
        self.viewSend.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.sendOnclick)))
        self.viewRecord.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.recordOnclick)))
        self.viewCamera.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cameraOnclick)))
    

        FirebaseHelper.shared.observe(user: 10, with: .value) { (value) in
            
            self.datasource = value
            DispatchQueue.main.async {
                self.reload()
            }
            
        }
        
        
        
        
    }
    
   
    
   @IBAction private func reload()
    {
        self.tableView.reloadData()
        if self.datasource.count>0{
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.scrollToRow(at: IndexPath(row: self.datasource.count-1, section: 0), at: .top, animated: true)
            })
        }
        
    }
    
    
    // MARK:- More Button Action
    
    @IBAction private func moreButtonAction(){
        
        
        
    }
    
    
    // MARK:- Image Button Action
    
    @IBAction private func imageButtonAction(){
        
        
        
    }
    
    
    //MARK:- Call Button Action
    
    @IBAction private func callButtonAction(){
        
        
    }
    
    
    //MARK:- Video Button Action
    
    @IBAction private func videoButtonAction(){
        
        
        
    }
    
    //MARK:- Camera Onclick Action
    
    @IBAction private func cameraOnclick(){
        
        SelectImageView.main.show(imagePickerIn: self) { (images) in
          
            if let image = images.first, let imageData = image.resizeImage(newWidth: 200), let data = UIImagePNGRepresentation(imageData){
                
                let task = FirebaseHelper.shared.write(to: 2, with: data, mime: .image, completion: { (isCompleted) in
                    
                    print("isCompleted  -- ",isCompleted)
                    
                })
                
                task.observe(.progress, handler: { (snapShot) in
                    
                  
                        print("Progress  ",(snapShot.progress!.completedUnitCount/snapShot.progress!.totalUnitCount) * 100)
                    
                    if #available(iOS 11.0, *) {
                        print(" Remaining ", snapShot.progress?.estimatedTimeRemaining)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                })
                
            }
            
        }
        
    }
    
    //MARK:- Record Onclick Action
    
    @IBAction private func recordOnclick(){
        
        
        
    }
    
    @IBAction private func sendOnclick(){
        
        FirebaseHelper.shared.write(to: 10, with: textViewSingleChat.text)
        self.textViewSingleChat.text = .Empty
    }
    
    
    //MARK:- Back Button Action
    
    @IBAction private func backButtonAction(){
        
        if navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
     super.touchesBegan(touches, with: event)
    
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            print(currentPoint)
            if !self.textViewSingleChat.bounds.contains(currentPoint){
                self.textViewSingleChat.resignFirstResponder()
            }
        }
    }
    
    
    private func setEmptyView(){
        
        DispatchQueue.main.async {
            
            self.tableView.backgroundView = self.datasource.count == 0 ?  {
                
                  let label = UILabel(frame: self.tableView.bounds)
                  label.textAlignment = .center
                  label.text = Constants.string.noChatHistory
                  label.font = UIFont(name: "Avenir-Medium", size: 18)
                  return label
                
                }() : nil
                
            }
     }
    
    
}


//MARK:- TableView Datasource and delegate

extension SingleChatController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row % 2 == 0 {
        
        
        if let chat = datasource[indexPath.row].response, let tableCell = tableView.dequeueReusableCell(withIdentifier: chat.sender == currentUserId ? senderCellId : recieverCellId, for: indexPath) as? ChatCell {
            
            if chat.sender == currentUserId {
                
                tableCell.setSender(values: datasource[indexPath.row])
                
            } else {
                
                tableCell.setRecieved(values: datasource[indexPath.row])
                
            }
            
            
            return tableCell
            
        }
        
        
        

//            if let cell = tableView.dequeueReusableCell(withIdentifier: senderCellId, for: indexPath)  {
//
//                cell.setSender(values: datasource[indexPath.row])
//
//                return cell
//
//            }
        
//        } else {
//
//            if let cell = tableView.dequeueReusableCell(withIdentifier: recieverCellId, for: indexPath) as? ChatCell {
//                cell.set(values: datasource[indexPath.row].0, isRecieved: datasource[indexPath.row].1)
//                return cell
//            }
//
//        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
}

//MARK:- UITextViewDelegate

extension SingleChatController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == Constants.string.writeSomething {
            textView.text = .Empty
            textView.textColor = .black
        }
        self.reload()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       
        if textView.text == .Empty {
            textView.text = Constants.string.writeSomething
            textView.textColor = .lightGray
            isSendShown = false
        }
        
    }
     
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
    
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if !textView.text.isEmpty {
            isSendShown = true
        } else  {
            isSendShown = false
        }
        
    }
    
    
}


