//
//  ViewController.swift
//  A2_iOS_Adel_101532466
//
//  Created by Adel Alhajhussein on 2026-04-09.
//

import UIKit
import CoreData


class ViewController: UIViewController {


    var products: [NSManagedObject] = []
    var index = 0

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        insertProductsIfNeeded()
        fetchProducts()
        displayProduct()
    }


    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }


    func insertProductsIfNeeded() {
        let context = getContext()


        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        let count = try! context.count(for: request)


        if count == 0 {
            for i in 1...10 {
                let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
                product.setValue(Int64(i), forKey: "productID")
                product.setValue("Product \(i)", forKey: "productName")
                product.setValue("Description for product \(i)", forKey: "productDescription")
                product.setValue(Double(i) * 10.0, forKey: "productPrice")
                product.setValue("Provider \(i)", forKey: "productProvider")
            }


            try! context.save()
        }
    }


    func fetchProducts() {
        let context = getContext()
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        products = try! context.fetch(request)
    }


    func displayProduct() {
        if products.count > 0 {
            let product = products[index]

            let id = product.value(forKey: "productID") as? Int64 ?? 0
            let name = product.value(forKey: "productName") as? String ?? ""
            let desc = product.value(forKey: "productDescription") as? String ?? ""
            let price = product.value(forKey: "productPrice") as? Double ?? 0.0
            let provider = product.value(forKey: "productProvider") as? String ?? ""

            nameLabel.text = "ID: \(id) - \(name)"
            descriptionLabel.text = "Description: \(desc)"
            priceLabel.text = String(format: "Price: $%.2f", price)
            providerLabel.text = "Provider: \(provider)"
        }
    }



    @IBAction func nextProduct(_ sender: UIButton) {
        if index < products.count - 1 {
            index += 1
            displayProduct()
        }
    }


    @IBAction func prevProduct(_ sender: UIButton) {
        if index > 0 {
            index -= 1
            displayProduct()
        }
    }
    
    @IBAction func searchProduct(_ sender: UIButton) {
        let keyword = searchField.text ?? ""


        let context = getContext()
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")


        if !keyword.isEmpty {
            request.predicate = NSPredicate(format: "productName CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@", keyword, keyword)
        }


        products = try! context.fetch(request)
        index = 0
        displayProduct()
    }
}



