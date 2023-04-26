//
//  MainViewController.swift
//  Faul-iOS
//
//  Created by VarunMalhotra on 19/03/23.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    
    @IBAction func signIn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignIn", sender: self)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignUp", sender: self)

    }
}
