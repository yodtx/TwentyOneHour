//
//  SocketIOManager.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 27.04.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    
    var socket = SocketIOClient(socketURL: URL(string: "https://datingservice.herokuapp.com")!, config: [.log(false), .forcePolling(true)])
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func subscribe(room: String)
    {
        socket.emit("subscribe", room)
        print("saasdasdksajdkjaksdjkdsjkasjd")
    }
    
    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: AnyObject]) -> Void) {
        socket.on("message") { (dataArray, socketAck) -> Void in
            
            var messageDictionary = [String: AnyObject]()
            
            messageDictionary["content"] = dataArray[0] as? String as AnyObject
            messageDictionary["room"] = dataArray[1] as? String as AnyObject
            messageDictionary["profile_id"] = dataArray[2] as? UInt as AnyObject
            messageDictionary["posted_at"] = dataArray[3] as? UInt as AnyObject
            print("------  -------  ------  -------  ------  -------  ------  -------  ------  -------  ------  -------")
            print(messageDictionary)
            completionHandler(messageDictionary)
        }
    }
    
    func getRoomId(completionHandler: @escaping (_ roomInfo: [String: String]) -> Void) {
        socket.on("chat") { (dataArray, socketAck) -> Void in
            
            var roomInfo = [String: String]()
            
            let dictData = dataArray[0]
            roomInfo["room"] = dictData as? String
            
//            roomInfo["profile_id"] = dataArray[0] as! String
//            roomInfo["room"] = dataArray[1] as! String
            print("------  -------  ------  -------  ------  -------  ------  -------  ------  -------  ------  -------")
            print(roomInfo)
            completionHandler(roomInfo)
        }
    }

    
}
