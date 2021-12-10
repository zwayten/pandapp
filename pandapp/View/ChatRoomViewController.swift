//
//  ChatRoomViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 10/12/2021.
//

import UIKit
import MessageKit

class Sender: SenderType {
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
    
    var senderId: String
    var displayName: String
    func set(senderId: String){
        self.senderId = senderId
    }
}

class Message: MessageType {
    init(sender: SenderType, messageId: String, sentDate: Date, kind: MessageKind) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
    }
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    
}

class ChatRoomViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
   
    var currentUser = Sender(senderId: "aaaaa", displayName: "rrrr")
    var otherUser = Sender(senderId: "bbb", displayName: "ffff")
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        let currentUserEmail = UserDefaults.standard.string(forKey: "email")
        
        
        messages.append(Message(sender: currentUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("aaaaaaaaa")))
        messages.append(Message(sender: otherUser,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-80400),
                                kind: .text("salut bb ")))
        messages.append(Message(sender: currentUser,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(-70400),
                                kind: .text("sousou bikech chna7welek")))
        messages.append(Message(sender: otherUser,
                                messageId: "4",
                                sentDate: Date().addingTimeInterval(-56400),
                                kind: .text("aaaaaaaaa")))
        
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

   

}
