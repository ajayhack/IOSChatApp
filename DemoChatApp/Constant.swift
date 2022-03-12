//
//  Constant.swift
//  DemoChatApp
//
//  Created by Ajay Thakur on 08/03/22.
//

import Foundation

struct Constant {
    static let RegisterToChat = "RegisterToChat"
    static let LoginToChat = "LoginToChat"
    static let appName = "ApnaChatApp"
    static let errorText = "Something went wrong!!!"
    static let LOGIN_STATUS = "login_status"
    static let RegisterNewUser = "registerNewUser"
    static let LoginUser = "loginUser"
    static let ChatViewCell = "chatViewCell"
    static let ChatTableViewCell = "ChatTableViewCell"
    static let MessageCollectionName = "messages"
    static var SenderName = "messageSender"
    static var SenderMessage = "message"
    static var TimeStamp = "timeStamp"
}

struct StoryboardID {
    static let ChatViewController = "ChatViewController"
    static let WelcomeController = "WelcomeController"
}

struct UserLogin {
    
    static func storeUserLogin(_ status : Bool){
        UserDefaults.standard.set(true, forKey: Constant.LOGIN_STATUS)
    }
    
    static func retriveUserLogin() -> Bool{
        return UserDefaults.standard.bool(forKey: Constant.LOGIN_STATUS)
    }
}

struct Message {
    let senderName : String
    let messageBody : String
}
