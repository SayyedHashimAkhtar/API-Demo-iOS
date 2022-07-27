//
//  FetchJSON.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import Foundation
import UIKit

class FetchJSON {
    
    private static let webServerUrl = "https://api.postcodes.io/"
    private static let requestOutcodes = "outcodes"
    private static let requestPostCodes = "postcodes"
    
    public enum ParametersType {
        case EndOfUrl
        case EmbededInUrl
    }

    private static func fetchData(requestType: String, withParameters params: Dictionary<String, String>, parametersType: ParametersType, showProgress: Bool, onComplete: @escaping ((_ results: [String : Any]) -> ())) {

        var urlStrings = webServerUrl + requestType

        switch(parametersType) {
        
        case .EndOfUrl:
            urlStrings.append("?")
            for key in params.keys {
                let value = params[key]!
                urlStrings.append("&\(key)=\(String(describing: value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)))")
            }
            break
            
        case .EmbededInUrl:
            if(params.count > 1) {
                for key in params.keys {
                    let value = params[key]!
                    urlStrings.append("/\(key)/\(String(describing: value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)))")
                }
            }
            else {
                let singleValue = params.first!.value
                let encodedString = singleValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                urlStrings.append("/")
                urlStrings.append(encodedString!)
            }
            break
            
        }
        

        
        let url = URL.init(string: urlStrings)!
        let task =  URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            do {
                
                if let error = error {
                print("Following error occurred while connecting to server: \(String(describing: error))")
                
                    DispatchQueue.main.async {
                        let alertController = UIAlertController.init(title: "WARNING", message: "...could not connect with server.", preferredStyle: .alert)
                        
                        let rootViewController = Globals.getRootViewController()
                        rootViewController.present(alertController, animated: true, completion: ({
                            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alertController.dismiss(animated: true, completion: nil) })
                        }))
                    }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController.init(title: "Bad Data", message: "Postcode is invalid", preferredStyle: .alert)

                        let rootViewController = Globals.getRootViewController()
                        rootViewController.present(alertController, animated: true, completion: ({
                            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in alertController.dismiss(animated: true, completion: nil) })
                        }))
                    }
                return
            }
            
                let responseData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.topLevelDictionaryAssumed) as! [String : Any]
                        
                onComplete(responseData)

                }
                catch {
                    
                }
        })
        task.resume()
    }

    static func getDataForPostCode(postCode: String, onComplete: @escaping ((_ adddress: Address?) -> ()) )
    {
        let params: Dictionary <String, String> = [
            "postCode" : postCode
        ]

        self.fetchData(requestType: requestPostCodes, withParameters: params, parametersType: .EmbededInUrl, showProgress: false, onComplete: {(results) in
            
            let address = ExtractJSON.getAddress(results)
            onComplete(address)
        })
    }

    static func getDataForOutCode(outCode: String, onComplete: @escaping ((_ adddress: Address?) -> ()) )
    {
        let params: Dictionary <String, String> = [
            "outCode" : outCode
        ]

        self.fetchData(requestType: requestPostCodes, withParameters: params, parametersType: .EmbededInUrl, showProgress: false, onComplete: {(results) in
            
            let address = ExtractJSON.getAddress(results)
            onComplete(address)
        })
    }
    
}
