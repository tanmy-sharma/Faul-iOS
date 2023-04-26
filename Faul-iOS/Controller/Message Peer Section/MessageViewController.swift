//
//  MessageViewController.swift
//  Faul-iOS
//
//  Created by VarunMalhotra on 20/03/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import CoreData
import FirebaseAuth

class MessageViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageText: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Messgae] = [
        Messgae(sender: "1@2.com", body: "Hi"),
        Messgae(sender: "a@b.com", body: "Hello"),
        Messgae(sender: "a@b.com", body: "What's up")
    ]
    
    override func viewDidLoad() {
        tableView.dataSource = self
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        // Do any additional setup after loading the view.
    }
    func loadMessages() {
            
            db.collection("messages")
                .order(by: "date")
                .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                                let newMessage = Messgae(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                       self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
                }
            }
        }
    @IBAction func sendButton(_ sender: Any) {
        if let messageBody = messageText.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "date": Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.messageText.text = ""
                    }
                }
            }
        }
    }
    
    
    
    
}
extension MessageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
                    cell.message?.text = message.body
                
                //This is a message from the current user.
                if message.sender == Auth.auth().currentUser?.email {
                    cell.leftImageView.isHidden = true
                    cell.rightImageView.isHidden = false
                    cell.messageView.backgroundColor = UIColor(named:"BrandLightPurple")
                    cell.message.textColor = UIColor(named:"BrandPurple")
                }
                //This is a message from another sender.
                else {
                    cell.leftImageView.isHidden = false
                    cell.rightImageView.isHidden = true
                    cell.messageView.backgroundColor = UIColor(named: "BrandPurple")
                    cell.message.textColor = UIColor(named: "BrandLightPurple")
                }
                return cell
    }
}
