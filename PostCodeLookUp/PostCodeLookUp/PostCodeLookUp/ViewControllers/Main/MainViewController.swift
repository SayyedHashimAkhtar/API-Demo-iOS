//
//  MainViewController.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func findByPostCode() {
        let postCodeViewController = PostCodeViewController()
        present(postCodeViewController, animated: true, completion: nil)
    }

    @IBAction func findByOutCode() {
        //TODO: Add screen for looking up address by partial post code.
    }
    
}
