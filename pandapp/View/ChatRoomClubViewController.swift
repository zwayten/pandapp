//
//  ChatRoomClubViewController.swift
//  pandapp
//
//  Created by yassine zitoun on 3/1/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Alamofire

class Senderr: SenderType {
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

class Messagee: MessageType {
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

class ChatRoomClubViewController: MessagesViewController{
   
    var clubEmail: String?
    var currentUser = Senderr(senderId: "aaaaa", displayName: "rrrr")
    var otherUser = Senderr(senderId: "bbb", displayName: "ffff")
    var messageList = [MessageType]()
    var fetchTabMessages = [Messages]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        DispatchQueue.main.async {
            self.fetchmessages()
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem()
            print("taille mtaa tableu :  \(self.fetchTabMessages.count)")
        }
        
        configureMessageCollectionView()
     
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        messageInputBar.topStackView.alignment = .center

        // or MiddleContentView padding
            
    }
    
    func fetchmessages()  {
        
        let token = UserDefaults.standard.string(forKey: "tokenClub")
        let clubEmail = UserDefaults.standard.string(forKey: "login")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
                      AF.request("\(ConnectionDb.baserequest())message/tosend/\(clubEmail!)", method: .get, headers: headers).responseDecodable(of: [Messages].self) { [weak self] response in
            self?.fetchTabMessages = response.value ?? []
            
            for item in self!.fetchTabMessages {
                print(item.whoSend)
                
                if item.whoSend == self!.currentUser.senderId {
                self!.messageList.append(Messagee(sender: self!.currentUser,
                                        messageId: UUID().uuidString,
                                        sentDate: Date().addingTimeInterval(-70400),
                                                 kind: .text(item.content)))
                }
                else if item.whoSend != self?.currentUser.senderId {
                    self?.otherUser.senderId = item.whoSend
                    self?.messageList.append(Messagee(sender: self!.otherUser,
                                            messageId: UUID().uuidString,
                                            sentDate: Date().addingTimeInterval(-70400),
                                                     kind: .text(item.content)))
                }
            }
            print("messageList : \(self!.messageList.count)")
                          self?.messagesCollectionView.reloadData()
        }
    }
    func fetch() {
        let token = UserDefaults.standard.string(forKey: "tokenClub")
        let clubEmail = UserDefaults.standard.string(forKey: "login")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())message/tosend/\(clubEmail!)", method: .get, headers: headers).responseDecodable(of: [Messages].self) { [weak self] response in
            self?.fetchTabMessages = response.value ?? []
           

            
        }
    }
   
    
}
    
extension ChatRoomClubViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate{
        func currentSender() -> SenderType {
        let currentUserEmail = UserDefaults.standard.string(forKey: "email")
        currentUser.senderId = currentUserEmail!
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messageList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        return messageList.count
    }

    @objc
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        processInputBar(messageInputBar)
    }

    func processInputBar(_ inputBar: InputBarAccessoryView) {
        // Here we can parse for which substrings were autocompleted
        let attributedText = inputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in
            let clubEmail = UserDefaults.standard.string(forKey: "login")
            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
            let currentUserEmail = UserDefaults.standard.string(forKey: "email")
            let ssMessege = Messages(content: inputBar.inputTextView.text, whoSend: currentUserEmail!, toSend: clubEmail! , _id: "")
            let mvm = MessagesViewModel()
            mvm.sendMessages(messages: ssMessege)
        }

        let components = inputBar.inputTextView.components
        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins()
        // Send button activity animation
        inputBar.sendButton.startAnimating()
        inputBar.inputTextView.placeholder = "Sending..."
        // Resign first responder for iPad split view
        inputBar.inputTextView.resignFirstResponder()
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = "Aa"
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
    }
    func isLastSectionVisible() -> Bool {
        
        guard !messageList.isEmpty else { return false }
        
        let lastIndexPath = IndexPath(item: 0, section: messageList.count - 1)
        
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    func insertMessage(_ message: Messagee) {
        messageList.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messageList.count - 1])
            if messageList.count >= 2 {
                messagesCollectionView.reloadSections([messageList.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        })
    }
    
    private func insertMessages(_ data: [Any]) {
        for component in data {
            let user = currentUser
            if let str = component as? String {
                let message = Messagee(sender: user,
                                      messageId: UUID().uuidString,
                                      sentDate: Date().addingTimeInterval(-86400),
                                      kind: .text(str))
                
                insertMessage(message)
            }
        }
    }
   
    
    
    func configureMessageCollectionView() {
    
        
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false

        showMessageTimestampOnSwipeLeft = true // default false
        
       // messagesCollectionView.refreshControl = refreshControl
    }

}
