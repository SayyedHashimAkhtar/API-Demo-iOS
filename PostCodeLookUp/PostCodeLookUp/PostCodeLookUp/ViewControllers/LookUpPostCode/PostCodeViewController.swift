//
//  PostCodeViewController.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import UIKit

class PostCodeViewController: UIViewController {

    @IBOutlet weak var postCodeInput: UITextField!
    @IBOutlet weak var longitudeValue: UILabel!
    @IBOutlet weak var latitudeValue: UILabel!
    @IBOutlet weak var inCodeValue: UILabel!
    @IBOutlet weak var outCodeValue: UILabel!
    @IBOutlet weak var regionValue: UILabel!
    
    @IBOutlet weak var progressMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func performLookup() {
        
        //First check the on device database for th post code.
        let address = Globals.getAppDatabase().getAddressByPostCode(postCode: postCodeInput.text!)
        
        if(address == nil) {
            //Check the internet
            FetchJSON.getDataForPostCode(postCode: postCodeInput.text!, onComplete: {(address) in
                Globals.getAppDatabase().createNewAddress(address: address!)
                DispatchQueue.main.async {
                    self.displayAddress(address: address!)
                }
            })
        }
        else {
            displayAddress(address: address!)
        }
        
    }
    
    func displayAddress(address: Address) {
        longitudeValue.text = address.longitude
        latitudeValue.text = address.latitude
        inCodeValue.text = address.inCode
        outCodeValue.text = address.outCode
        regionValue.text = address.region
    }
    
    func announceResult(message: String) {
        progressMessage.text = message
    }

    @IBAction func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
