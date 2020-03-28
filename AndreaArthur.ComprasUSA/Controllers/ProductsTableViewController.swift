//
//  ProductsTableViewController.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 20/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit
import CoreData

class ProductsTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<Product>!
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Sua lista está vazia!"
        label.textAlignment = .center
        
        loadProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "productSegue"{
            let vc = segue.destination as! ProductViewController
            if let products = fetchedResultController.fetchedObjects {
            vc.product = products[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    func loadProducts(){
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let sortDescriptorName = NSSortDescriptor(key:"name", ascending: true)
        let sortDescriptorState = NSSortDescriptor(key:"state.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorName, sortDescriptorState]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        
        tableView.backgroundView = count == 0 ? label : nil
        
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell

        guard let product = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        
        cell.prepare(with: product)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let product = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(product)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

extension ProductsTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        //metodo disparado qdo algum objeto eh alterado
        
        switch type {
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
            }
            default:
                tableView.reloadData()
        }
    }
}
