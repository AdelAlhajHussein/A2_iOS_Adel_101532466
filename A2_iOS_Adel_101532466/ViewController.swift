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
            nameLabel.text = product.value(forKey: "productName") as? String
            descriptionLabel.text = product.value(forKey: "productDescription") as? String


            if let price = product.value(forKey: "productPrice") as? Double {
                priceLabel.text = "$\(price)"
            } else {
                priceLabel.text = "$0.0"
            }


            providerLabel.text = product.value(forKey: "productProvider") as? String
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
}



