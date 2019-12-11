//
//  ChatViewController.swift
//  Show-me-chat
//
//  Created by Mark Dorofeev, Anton Brichev on 14/11/2019.
//  Copyright © 2019 Anton Brichev, Mark Dorofeev. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseCore
import FirebaseFirestore

class ChatViewController: JSQMessagesViewController {
    var messages = [JSQMessage]()
    var db: Firestore!
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
    
    

    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        let defaults = UserDefaults.standard
        
        if  let id = defaults.string(forKey: "jsq_id"),
            let name = defaults.string(forKey: "jsq_name") {
            senderId = id
            senderDisplayName = name
        } else {
            senderId = String(arc4random_uniform(999999))
            senderDisplayName = randomString(length: 5);
            
            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()
        }
        
        title = "Chat: \(senderDisplayName!)"
        
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        
        db.collection("chats").document("DW8AyeNPQQuIhhXUfRUD").collection("messages")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching messages: \(error!)")
                    return
                }
                for document in documents {
                    print("Message \(document.documentID) => \(document.data())")
                    if let message = JSQMessage(senderId: document.data()["senderId"] as? String, displayName: document.data()["senderId"] as? String, text: (document.data()["text"] as! String)) {
                        self.messages.append(message)
                        self.finishReceivingMessage()
                    }

                }
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
    db.collection("chats").document("DW8AyeNPQQuIhhXUfRUD").collection("messages").document().setData([
            "senderId": senderId!,
            "text": text!
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

        finishSendingMessage()
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
 }
