//
//  SplashScreenViewController.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var birdyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let birdyArray:[UIImage] = [
            UIImage(named: "Birdy2.png")!, UIImage(named: "Birdy3.png")!, UIImage(named: "Birdy4.png")!, UIImage(named: "Birdy3.png")! ]
        
        birdyImageView.animationImages = birdyArray
        
        birdyImageView.animationDuration = 1
        birdyImageView.animationRepeatCount = 3
        birdyImageView.startAnimating()
        
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in self.nextScreen(nil) })
        
    }
    
    func nextScreen(_ nextViewController:UIViewController?) {
        
        var viewController = nextViewController
        
        if(viewController == nil ) {
            viewController = MainViewController()
        }
    
        self.view.window?.rootViewController = viewController
    }

}
