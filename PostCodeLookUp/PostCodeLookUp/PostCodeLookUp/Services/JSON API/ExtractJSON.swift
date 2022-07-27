//
//  ExtractJSON.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import Foundation
import UIKit

class ExtractJSON {
    
    static func getAddress(_ jsonResults: [String : Any]) -> Address? {
        
        var address: Address? = nil
        
        do {
            let dataResult = jsonResults["result"] as! Dictionary<String, Any>
            
            let postCode = dataResult["postcode"] as? String ?? "N/A"
            let longitude = dataResult["longitude"] as? Double
            let latitude = dataResult["latitude"] as? Double
            let incode = dataResult["incode"] as? String
            let outcode = dataResult["outcode"] as? String
            let region = dataResult["region"] as? String
            
            let longitudeString = String(format: "%.6f", longitude!)
            let latitudeString = String(format: "%.6f", latitude!)
            
            address = Address(id: -1, postCode: postCode, longitude: longitudeString, latitude: latitudeString, inCode: incode!, outCode: outcode!, region: region!)            
        }
        catch {
            print("JSON Data issue")
        }
        
        return address
    }
    
}
