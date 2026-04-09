//
//  ProductListViewController.swift
//  A2_iOS_Adel_101532466
//
//  Created by Adel Alhajhussein on 2026-04-09.
//

import UIKit
import CoreData

class ProductListViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    var products: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        showProducts()
    }

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func fetchProducts() {
        let context = getContext()
        let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
        products = try! context.fetch(request)
    }

    func showProducts() {
        var output = ""

        for product in products {
            let name = product.value(forKey: "productName") as? String ?? ""
            let desc = product.value(forKey: "productDescription") as? String ?? ""

            output += "Name: \(name)\n"
            output += "Description: \(desc)\n"
            output += "------------------------\n"
        }

        textView.text = output
    }
}

