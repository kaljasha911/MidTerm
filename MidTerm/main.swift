//
//  main.swift
//  MidTerm
//
//  Created by Jashan Kalsi on 2025-06-20.
//

import Foundation

protocol Payable {
    var price: Double { get set }
    func calculateTotalPrice(withTax taxRate: Double) -> Double
}

class Product {
    let id: UUID
    let name: String
    
    init(id: UUID=UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

class Electronics: Product, Payable {
    var warrantyPeriod: Int
    var price: Double
    
    init(name: String, warrantyPeriod: Int, price: Double) {
        self.warrantyPeriod = warrantyPeriod
        self.price = price
        super.init(name: name)
    }
    
    func calculateTotalPrice(withTax taxRate: Double) -> Double {
        return price + (price * taxRate)
    }
    
}

class Clothing: Product, Payable {
    var size: String
    var material: String
    var price: Double
    
    init(name: String, size: String, price: Double, material: String) {
        self.size = size
        self.price = price
        self.material = material
        super.init(name: name)
    }
    
    func calculateTotalPrice(withTax taxRate: Double) -> Double {
        return price + (price * taxRate)
    }
}

class ProductManager {
    private var products: [Product] = []
    
    func addProduct(_ product: Product) {
        products.append(product)
    }
    
    func displayProducts() {
        if products.isEmpty {
            print("No products found.")
        } else {
            for product in products {
                print("------------------------------")
                print("Product ID: \(product.id), Name: \(product.name)")
            }
            
            if let electronics = products.first as? Electronics {
                print("Type: Electronics")
                print("Warranty Period: \(electronics.warrantyPeriod) years")
                print ("Price: \(electronics.price)")
                print ("Total Price with tax included: \(electronics.calculateTotalPrice(withTax: 0.13))")
            } else if let clothing = products.first as? Clothing {
                print("Type: Clothing")
                print("Size: \(clothing.size)")
                print("Material: \(clothing.material)")
                print( "Price: %.2f", clothing.price)
                print ("Total Price with tax included: %.2f", clothing.calculateTotalPrice(withTax: 0.13))
            }
            
            print("---------------------------")
        }
        
        }
}


func ShowMenu() {
    let manager = ProductManager()
    
    while true {
        print("\nMenu")
        print("1. Add new Item")
        print("2. Display All Items")
        print("3. Exit")
        print("Enter your choice: ", terminator: "")
        
        if let choice = readLine(), let option = Int(choice)  {
            switch option {
            case 1:
                addNewItem(manager: manager)
            case 2:
                manager.displayProducts()
            case 3:
                print( "Existing application!\n" )
                return
            default:
                break
            }
        } else {
            print("Invalid Input, please enter a number")
        }
    }
}

func addNewItem(manager: ProductManager) {
    print("Select Product type: 1 for Electronics, 2 for Clothing", terminator: " ")
    if let typeChoice = readLine(), let type = Int(typeChoice) {
        print("Enter Product Name: ", terminator: "" )
        guard let name = readLine(), !name.isEmpty else {
            print("Invalid Name")
            return
        }
        print( "Enter Product Price: ", terminator: "" )
        guard let priceInput = readLine(), let price = Double(priceInput) else {
            print("Invalid Price")
            return
        }
        switch type {
        case 1:
            print( "Enter warranty period in months: ", terminator: "" )
            guard let warrantyInput = readLine(), let warranty = Int(warrantyInput) else {
                print("Invalid warranty period")
                return
            }
            let electronics = Electronics(name: name, warrantyPeriod: warranty, price: price)
            manager.addProduct(electronics)
            print("Electronics Item added")
        case 2:
            print("Enter size", terminator: " ")
            guard let size = readLine(), !size.isEmpty else {
                print("Invalid Size")
                return
            }
            print("Enter Material", terminator: " ")
            guard let material = readLine(), !material.isEmpty else {
                print("Invalid Material")
                return
            }
            let clothing = Clothing(name: name, size: size, price: price, material: material)
            manager.addProduct(clothing)
            print("Clothing Item added")
        default:
            print("Invalid Product Type selected")
        }
    }
        else {
            print("Invalid Input")
        }
}

ShowMenu()
