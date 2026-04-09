//
//  AddProductViewController.swift
//  A2_iOS_Adel_101532466
//
//  Created by Adel Alhajhussein on 2026-04-09.
//



import UIKit
import CoreData


class AddProductViewController: UIViewController {


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var providerField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.layer.borderWidth = 1

        descField.layer.borderColor = UIColor.black.cgColor
        descField.layer.borderWidth = 1

        priceField.layer.borderColor = UIColor.black.cgColor
        priceField.layer.borderWidth = 1

        providerField.layer.borderColor = UIColor.black.cgColor
        providerField.layer.borderWidth = 1
    }


    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }


    @IBAction func saveProduct(_ sender: UIButton) {
        let context = getContext()


        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)


        product.setValue(Int64(Date().timeIntervalSince1970), forKey: "productID")
        product.setValue(nameField.text ?? "", forKey: "productName")
        product.setValue(descField.text ?? "", forKey: "productDescription")
        product.setValue(Double(priceField.text ?? "0") ?? 0.0, forKey: "productPrice")
        product.setValue(providerField.text ?? "", forKey: "productProvider")


        try! context.save()


        navigationController?.popViewController(animated: true)
    }
}




