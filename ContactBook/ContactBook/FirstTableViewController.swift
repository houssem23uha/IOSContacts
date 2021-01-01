//
//  FirstTableViewController.swift
//  ContactBook
//
//  Created by Houssem Eddine Hadji

import UIKit
import CoreData

class FirstTableViewController: UITableViewController {
    var addContact: String?
   
    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
       
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        contactTableView.reloadData()
    }
    

    // MARK: - Table view data source
    
    func allContact() -> [EContact] {
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = AppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<EContact>(entityName: "Contact")
        
        do {
            return try context.fetch(request)
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
            return []
        }
    }
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContact().count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FirstContactCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! FirstTableViewCell
        
        let set = allContact().sorted {($0.firstName ?? "") < ($1.firstName ?? "")}
        
        cell.nameLabel?.text = set[indexPath.row].firstName! + " " + set[indexPath.row].secondName!
            
        cell.phoneLabel.text = set[indexPath.row].phoneNumber!


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(allContact()[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        } 
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Navigation


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? EditContactViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell){
            controller.contact = allContact()[indexPath.row]
            controller.delegate = self
            
        }
        
    }
    
    func contactHasChanged(_ contact: EContact){
        tableView.reloadData()
    }
    
    @IBAction func editingEndForSeque(returnSegue: UIStoryboardSegue){
        if let controller = returnSegue.source as? EditContactViewController{
            if let contact = controller.contact, let firstName = controller.firstNameTextField.text, firstName.count > 0,  let secondName = controller.secondNameTextField.text, secondName.count > 0, let phone = controller.phoneTextField.text, phone.count > 0,  let adress = controller.adressTextField.text, adress.count > 0, let email = controller.emailTextField.text, email.count > 0 {
                contact.firstName = firstName
                contact.secondName = secondName
                contact.phoneNumber = phone
                contact.adress = adress
                contact.email = email
                
                contactHasChanged(contact)
            }
        }
       
        
    }


    @IBAction func CreateInitialBase(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var contacts = [Contact]()
        ContactBase.shared.allContact.forEach ({ contact in
            contacts.append(contact)
        })
        
        contacts.forEach({ contact in
            let pcontact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: context) as! EContact
            pcontact.firstName = contact.firstName
            pcontact.secondName = contact.secondName
            pcontact.phoneNumber = contact.phoneNumber
            pcontact.adress = contact.adress
            pcontact.email = contact.email
        })
        
        tableView.reloadData()

    }
    

    
    
    
    
}
