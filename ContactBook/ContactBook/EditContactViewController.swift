//
//  EditContactViewController.swift
//  ContactBook
//
//  Created by Houssem Eddine Hadji


import UIKit

class EditContactViewController: UIViewController {
    var contact: EContact?
    weak var delegate: FirstTableViewController?

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBOutlet weak var adressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstNameTextField.text = contact?.firstName
        secondNameTextField.text = contact?.secondName
        adressTextField.text = contact?.adress
        phoneTextField.text = contact?.phoneNumber
        emailTextField.text = contact?.email
        
        navigationItem.title = contact?.secondName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let contact = contact {
            var changed = false
            if let firstName = firstNameTextField.text, firstName.count > 0 {
                contact.firstName = firstName
                changed = true
            }
            if let secondName = secondNameTextField.text, secondName.count > 0 {
                contact.secondName = secondName
                changed = true
            }
            if let adress = adressTextField.text, adress.count > 0 {
                contact.adress = adress
                changed = true
            }
            if let phone = phoneTextField.text, phone.count > 0 {
                contact.phoneNumber = phone
                changed = true
            }
            if let email = emailTextField.text, email.count > 0 {
                contact.email = email
                changed = true
            }
            
            if changed {
                delegate?.contactHasChanged(contact)
            }
            
            
            
        }
        

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
    
    
    
    
    
    @IBAction func backgroungTap(_ sender: UIControl) {
        
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        adressTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
