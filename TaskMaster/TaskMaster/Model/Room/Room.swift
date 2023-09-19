//
//  Room.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import CloudKit

struct Room: Recordable {
    var id: String
    var name: String
    var tasksID:  [String] = [] //tasks de qm? talvez uma tupla com tasks e seus users
    var memberID: [String] = []
    var lastTaskAdd: Date?//n entendi isso e opcional no banco n rola
    
    var password: String = ""//xcode tava reclamando ai coloquei o = ""
    var creatorId: String = ""//mesma coisa aqui
    var rewardCompletion: Int = 3
    var penaltyFail: Int = 2
    var maxEditTime: Int = 0 //hora maxima pra alterar as tasks em um dia
    //var taskPictures:
    //var codigo/link pra entrar?
    
    
    var record: CKRecord?
    
    init(){
        self.id = UUID().uuidString
        self.name = ""
        self.password = ""
        self.creatorId = ""
    }
    
    init?(record: CKRecord) {
        if let id = record["id"] as? String {
            self.id = id
        } else {
            return nil
        }
        
        if let name = record["name"] as? String {
            self.name = name
        } else {
            return nil
        }
    }
}
