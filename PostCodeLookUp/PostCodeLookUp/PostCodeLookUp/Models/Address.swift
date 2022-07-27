//
//  Address.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import Foundation

class Address {
    
    var id: Int64
    var postCode: String
    var longitude: String
    var latitude: String
    var inCode: String
    var outCode: String
    var region: String
    
    init(id: Int64, postCode: String, longitude: String, latitude: String, inCode: String, outCode: String, region: String) {
        self.id = id
        self.postCode = postCode
        self.longitude = longitude
        self.latitude = latitude
        self.inCode = inCode
        self.outCode = outCode
        self.region = region
    }
    
}
