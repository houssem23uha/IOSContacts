//
//  ThirdTableViewController.swift
//  ContactBook
//
//  Created by Houssem Eddine Hadji


import UIKit
import CoreData

class ThirdViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func firstNameDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func secondNameDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func adressDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func phoneDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func emailDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    
    
    
    
    @IBAction func backgroundTap(_ sender: UIControl) {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        adressTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func onClickAdd(_ sender: UIBarButtonItem) {
        
        if let firstName = firstNameTextField.text, let secondName = secondNameTextField.text, let adress = adressTextField.text, let phone = phoneTextField.text, let email = emailTextField.text{
            
            let AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = AppDelegate.persistentContainer.viewContext
           
            
            let newContact = EContact(context: context)
            
            newContact.firstName = firstName
            newContact.secondName = secondName
            newContact.adress = adress
            newContact.phoneNumber = phone
            newContact.email = email
            
            AppDelegate.saveContext()
        
            firstNameTextField.text = nil
            secondNameTextField.text = nil
            adressTextField.text = nil
            phoneTextField.text = nil
            emailTextField.text = nil
            
     
        }
        
        
    }
}
