//
//  ProductAddEditViewController.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 20/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class ProductAddEditViewController: UIViewController {

    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfUSPrice: UITextField!
    @IBOutlet weak var swCreditCard: UISwitch!
    @IBOutlet weak var btAddEddit: UIButton!
    @IBOutlet weak var btProduct: UIButton!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addEditImage(_ sender: UIButton) {
    }
    
    
    @IBAction func addEditProduct(_ sender: UIButton) {
        
        if product == nil {
            product = Product(context: context)
        }
        
        product.name = tfName.text
        product.usPrice = Double(tfUSPrice.text!) ?? 0
        product.useCreditCard = swCreditCard.isOn
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}





