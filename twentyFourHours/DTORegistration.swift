//
//  DTORegistration.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 27.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import Foundation

class DTORegistration
{
    // 13
    var name: String!
    var sex: Int!
    var iMeetSex: Int! // polovie predpochtenia
    var town: Int!
    var age: Int!
    var sexPrefer: String!
    var bodyType: Int!
    var height: Double!
    var weight: Double!
    var aboutMe: String!
    var photo: String!   // x3
    var userName: String!
    var password: String!
    
    init (name: String, sex: Int, iMeetSex: Int, town: Int, age: Int, sexPrefer: String, bodyType: Int, height: Double, weight: Double, aboutMe: String, photo: String, userName: String, password: String)
    {
        self.name = name
        self.sex = sex
        self.iMeetSex = iMeetSex
        self.town = town
        self.age = age
        self.sexPrefer = sexPrefer
        self.bodyType = bodyType
        self.height = height
        self.weight = weight
        self.aboutMe = aboutMe
        self.photo = photo
        self.userName = userName
        self.password = password
    }
    
    init()
    {
        self.name = ""
        self.sex = 0
        self.iMeetSex = 0
        self.town = 0
        self.age = 0
        self.sexPrefer = ""
        self.bodyType = 0
        self.height = 0
        self.weight = 0
        self.aboutMe = ""
        self.photo = "devushka-lico-voda-glaza.jpg"
        self.userName = ""
        self.password = ""
    }
}
