//
//  ChatVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 29/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseAuth

class ChatVC: JSQMessagesViewController {
    
    //MARK: ~Properties
    
    var messages = [JSQMessage]()
    var timestamp: String {
        return "\(NSDate().timeIntervalSince1970)"
    }
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()

    
    var chattingWith: String = ""

    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = Auth.auth().currentUser!.uid
        senderId = uid
        senderDisplayName = "harshi"
        

        // Do any additional setup after loading the view.
        
        let query = Constants.refs.databaseChats.whereField("name", isEqualTo: "harshi")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { [weak self] (snapshot, error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    return
                    
                }
                self?.messages.removeAll()
                
                if let snapshot = snapshot {
                    
                    for document in snapshot.documents {
                        
                        if let data = document.data() as? [String: String],
                            let name = data["name"],
                            let id = data["sender_id"],
                            let text = data["text"],
                            !(text.isEmpty) {
                            if let message = JSQMessage(senderId: id, displayName: name, text: text)
                            {
                                self?.messages.append(message)
                                
                                self?.finishReceivingMessage()
                            }
                        }
                    }
                }
                
        }
    }
    
   
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.refs.databaseChats.document()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text, "timestamp": timestamp]
        
        ref.setData(message as [String : Any])
        
        finishSendingMessage()
    }
    
    

}
