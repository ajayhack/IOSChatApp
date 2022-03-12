//
//  ChatViewController.swift
//  DemoChatApp
//
//  Created by Ajay Thakur on 05/03/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView? = nil
    
    @IBOutlet weak var chatTF: UITextField? = nil
    
    private var db = Firestore.firestore()
    
    private var messageDataList : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constant.appName
        navigationItem.hidesBackButton = true
        chatTF?.delegate = self
        chatTableView?.register(UINib(nibName: Constant.ChatTableViewCell, bundle: nil), forCellReuseIdentifier: Constant.ChatViewCell)
        chatTableView?.dataSource = self
        chatTableView?.delegate = self
        loadChatsFromFirestore()
    }
    
    private func loadChatsFromFirestore(){
        db.collection(Constant.MessageCollectionName).order(by: Constant.TimeStamp).addSnapshotListener { querySnapshot, error in
            self.messageDataList.removeAll()
            if let e = error {
                print("There is some issue in fetching data from Firestore \(e)")
            }else{
                if let docSnapshot = querySnapshot?.documents {
                    for doc in docSnapshot {
                        let data = doc.data()
                        if let senderMessage = data[Constant.SenderMessage] as? String , let messageSenderName = data[Constant.SenderName] as? String {
                            let messageModel = Message(senderName: messageSenderName, messageBody: senderMessage)
                            self.messageDataList.append(messageModel)
                            self.refreshTableView()
                        }
                    }
                }
            }
        }
    }
    
    private func refreshTableView(){
        DispatchQueue.main.async {
            self.chatTableView?.reloadData()
            self.chatTableView?.scrollToRow(at: IndexPath(row: self.messageDataList.count - 1, section: 0), at: .top, animated: true)
        }
    }
    
    
    @IBAction func doUserLogout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            UserLogin.storeUserLogin(false)
            navigationController?.popToRootViewController(animated: true)
        }catch {
            print(Constant.errorText)
        }
    }
}

extension ChatViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chatTF?.endEditing(true)
        saveChatToDB()
        return true
    }
    
    func saveChatToDB(){
        if let messageBody = chatTF?.text , let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constant.MessageCollectionName).addDocument(data: [
                Constant.SenderName : messageSender,
                Constant.SenderMessage : messageBody,
                Constant.TimeStamp : Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("Something went wrong in saving data to firestore database. \(e)")
                }else{
                    print("Data Saved Successfully")
                    self.chatTF?.text = ""
                }
            }
        }
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return messageDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.ChatViewCell, for: indexPath) as! ChatTableViewCell
        let message = messageDataList[indexPath.row]
        cell.chatMessageLabel.text = message.messageBody
        
        //If Current User Logged In:-
        if message.senderName == Auth.auth().currentUser?.email {
            cell.chatCellView.backgroundColor = .red
            cell.chatMessageLabel.textColor = .white
            cell.girlImage.isHidden = true
            cell.boyImage.isHidden = false
        }
        //If Another User Logged In:-
        else{
            cell.chatCellView.backgroundColor = .blue
            cell.chatMessageLabel.textColor = .white
            cell.girlImage.isHidden = false
            cell.boyImage.isHidden = true
        }
        return cell
    }
}

extension ChatViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(messageDataList[indexPath.row].senderName)
    }
}
