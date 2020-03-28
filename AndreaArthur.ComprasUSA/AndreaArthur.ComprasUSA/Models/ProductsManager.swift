//
//  ProductsManager.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 28/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import CoreData

class ProductsManager {
    
    static let shared = ProductsManager()
    var products: [Product] = []
    
    func loadProducts(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptorName = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptorState = NSSortDescriptor(key:"state.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorName, sortDescriptorState]
        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}

