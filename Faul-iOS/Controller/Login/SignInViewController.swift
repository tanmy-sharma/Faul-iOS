//
//  SignInViewController.swift
//  Faul-iOS
//
//  Created by VarunMalhotra on 18/03/23.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController{

    @IBOutlet var unameField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var googleButton: UIButton!
    @IBOutlet var appleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passField.delegate = self
        unameField.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


    @IBAction func signInButton(_ sender: UIButton) {
        loginButtonTapped()
    }
    
    
    @IBAction func signInUsingAPI(_ sender: UIButton) {
    }
    
    
    @IBAction func didNotRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "DidNotRegister", sender: self)
    }
    
    private func loginButtonTapped(){
        unameField.resignFirstResponder()
        passField.resignFirstResponder()
        
        guard let email = unameField.text, let password = passField.text,
              !email.isEmpty, !password.isEmpty, password.count >=  6 else{
            alertUserLoginError()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {authResult, error in
            guard let result = authResult ,error == nil else{
                print("Failed to Login in user with email: \(email)")
                return
            }
            let user = result.user
            print("Logged In User: \(user)")
            self.performSegue(withIdentifier: "HomePageSegue", sender: self)
        })
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "Woops", message: "Please Enter All Information", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}

extension SignInViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == unameField{
            passField.becomeFirstResponder()
        }
        else if textField == passField{
            loginButtonTapped()
        }
        return true
    }
    
}
