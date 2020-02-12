//
//  SignUpViewController.swift
//  Study Flash
//
//  Created by Alex Cheung on 31/10/2019.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let persistenceManager: PersistenceManager
    
    
    // MARK: -Dependency Injection - Init
    init?(coder: NSCoder, persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("you must with a Persistance Maanager")
    }
    

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Outlet Action
    @IBAction func endEditingUsername(_ sender: Any) {
        username = usernameTextField.text
    }
    
    @IBAction func endEditingEmail(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        do {
            try self.email = Email(email)
            print("Valid Email")
        }   catch EvaluateError.isEmpty {
            print("it is empty")
        }   catch EvaluateError.isNotValidEmailLength {
            print("Not valid length")
        }   catch EvaluateError.isNotValidEmailAddress {
            print("Not valid Email Address")
        }   catch {
            print("someerror")
        }
    }
    
    @IBAction func endEditPassword(_ sender: Any) {
        password = passwordTextField.text
    }
    
    //MARK: - variable
    
    var username: String?
    var email: Email?
    var password: String?
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
//        createUser()
        getUser()
        
        
        
    }
    
    //MARK: - CoreData
    
    func printUsers() {
        users.forEach({print($0.username)})
    }
    
    func createUser() {
        let user = User(context: persistenceManager.context)
        user.username = "david"
        user.email = "123@gmail.com"
        user.password = "123"
        
        persistenceManager.save()
    }
    
    func getUser() {
        let users = persistenceManager.fetch(User.self)
        self.users = users
        
        printUsers()
        
        let deadline = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: deleteUser)

    }
    
    func updateUser() {
        let firstUser = users.first!
        
        firstUser.username += " - Updated"
        
        persistenceManager.save()
        printUsers()
        
    }
    
    func deleteUser() {
        if let firstUser = users.first {
            persistenceManager.delete(firstUser)

        }
        
        printUsers()
        
    }
    
    //MARK: - Functions
    
    func setUpUI() {
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    func validateAllInput() -> Bool {
        if isUsernameValidated() && isPasswordValidated() && isEmailValidated() {
            return true
        } else {
            return false
        }
    }
    
    func isUsernameValidated() -> Bool {
        //check whether the username is existed in database
        return true
    }
    
    func isPasswordValidated() -> Bool {
        if passwordTextField.text == confirmPasswordTextField.text {
            return true
        } else {
            print("Alert: Passwords are not the same")
            return false
        }
    }
    
    func isEmailValidated() -> Bool {
        if email != nil {
            return true
        } else {
            return false
        }
    }
    
    func createAccount() {
        guard
            let username = username,
            let email = email,
            let password = password else {return}
        
//        let user = User(name: username, email: email, password: password)
        
//        print(user)

        sendDataToDatabase()
    }
    
    func sendDataToDatabase() {
        //send user data to database
    }
    
    @IBAction func tappedOnSubmitButton(_ sender: Any) {
        // Force End Editing to check
        emailTextField.endEditing(true)
        
        print(username, email, password)

        guard validateAllInput() == true else { return }

        createAccount()
        print("Account Created!")
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
