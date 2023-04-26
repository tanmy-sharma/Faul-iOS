//
//  SignUpViewController.swift
//  Faul-iOS
//
//  Created by VarunMalhotra on 18/03/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var pass: UITextField!
    @IBOutlet var confirmPass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        pass.delegate = self
        confirmPass.delegate = self
// Do any additional setup after loading the view.
    }
    @IBAction func submitForm(_ sender: UIButton) {
        submitButtonTapped()
    }
    
    private func submitButtonTapped(){
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        email.resignFirstResponder()
        pass.resignFirstResponder()
        confirmPass.resignFirstResponder()
        
        guard let first_Name = firstName.text,
              let last_Name = lastName.text,
              let email_ = email.text,
              let pass_ = pass.text,
              !first_Name.isEmpty,
              !last_Name.isEmpty,
              !email_.isEmpty,
              !pass_.isEmpty,
              pass_.count >= 6
            else{
                  alertUserSignUpError()
                  return
              }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email_, password: pass_, completion: {authResult, error in
            guard let result = authResult ,error == nil else{
                print("Error Creating User")
                return
            }
            let user = result.user
            print("Created User: \(user)")
            self.performSegue(withIdentifier: "HomePageSegue", sender: self)
        })
    }
    func alertUserSignUpError(){
        let alert = UIAlertController(title: "Woops", message: "Please Enter All Information to create a new account. ", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    

}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstName{
            lastName.becomeFirstResponder()
        }
        else if textField == lastName{
            email.becomeFirstResponder()
        }
        else if textField == email{
            pass.becomeFirstResponder()
        }
        else if textField == pass{
            confirmPass.becomeFirstResponder()
        }
        else if textField == confirmPass{
            submitButtonTapped()
        }
        return true
    }
}
