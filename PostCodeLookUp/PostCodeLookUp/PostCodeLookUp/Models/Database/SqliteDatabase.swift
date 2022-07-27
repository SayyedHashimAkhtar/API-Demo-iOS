//
//  SqliteDatabase.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import Foundation
import SQLite

class SqliteDatabase {
    
    var Database: Connection?
    
    let DatabaseName = "lookup"
    let DatabaseExtension = "sqlite3"
    
    init() {
        //Establish path
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = dirPaths[0]
        NSLog("Documents Dir: ", documentDirectory)
        
        let completeDatabaseName = "\(DatabaseName).\(DatabaseExtension)"
        
        let databasePath = NSURL(fileURLWithPath: documentDirectory).appendingPathComponent(completeDatabaseName)?.path
        NSLog("Database Path: ", databasePath!)
        
        //Does database exist?
        let fileManager = FileManager.default
        if(fileManager.fileExists(atPath: databasePath!)) {
            NSLog("App Database already exists")
            //Does it need updating?
            
            //Update database
        }
        else {
            //Setup database
            do {
                let resDBPath = Bundle.main.path(forResource: DatabaseName, ofType: DatabaseExtension)
                try fileManager.copyItem(atPath: resDBPath!, toPath: databasePath!)
                NSLog("App Database has been setup")
            }
            catch {
                NSLog("Could not deploy database.")
                return
            }
            
        }
        
        //Open the Database file for work.
        do {
            Database = try Connection(databasePath!)
        }
        catch {
            NSLog("Failed to open database.")
        }
        
    }
    
    //Add new address
    func createNewAddress(address: Address) -> Bool {
        do {
            let statement = try Database!.prepare("INSERT INTO KnownAddress (PostCode, Longitude, Latitude, InCode, OutCode, Region, DeleteRow) VALUES (?, ?, ?, ?, ?, ?, ?)")
            try statement.run(address.postCode, address.longitude, address.latitude, address.inCode, address.outCode, address.region, 0)
            
            let lastRowId = Database?.lastInsertRowid
            
            return ((Database?.changes)!) > 0
            
        }
        catch {
            print(error)
            return false
        }
    }
    
    func getAddressByPostCode(postCode: String) -> Address? {
        var address: Address? = nil
        
        do {
            for row in try Database!.prepare("SELECT AddressId, PostCode, Longitude, Latitude, InCode, OutCode, Region FROM KnownAddress WHERE PostCode LIKE '%\(postCode)%'") {
                let addressId = row[0] as? Int64
                let postCode = row[1] as? String
                let longitude = row[2] as? String
                let latitude = row[3] as? String
                let inCode = row[4] as? String
                let outCode = row[5] as? String
                let region = row[6] as? String
                
                address = Address(id: addressId!, postCode: postCode!, longitude: longitude!, latitude: latitude!, inCode: inCode!, outCode: outCode!, region: region!)
            }
            
        } catch {
            print (error)
        }
        
        return address
    }
    
    func getAddressByOutCode(outCode: String) -> Address? {
        var address: Address? = nil
        
        do {
            for row in try Database!.prepare("AddressId, PostCode, Longitude, Latitude, InCode, OutCode, Region FROM KnownAddress WHERE OutCode LIKE '%\(outCode)%'") {
                let addressId = row[0] as? Int64
                let postCode = row[1] as? String
                let longitude = row[2] as? String
                let latitude = row[3] as? String
                let inCode = row[4] as? String
                let outCode = row[5] as? String
                let region = row[6] as? String
                
                address = Address(id: addressId!, postCode: postCode!, longitude: longitude!, latitude: latitude!, inCode: inCode!, outCode: outCode!, region: region!)
            }
            
        } catch {
            print (error)
        }
        
        return address
    }

}
