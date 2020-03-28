//
//  ProductViewController.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 20/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbUSPrice: UILabel!
    @IBOutlet weak var lbTaxes: UILabel!
    @IBOutlet weak var ivProduct: UIImageView!

    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProductAddEditViewController
        vc.product = product
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbName.text = product.name
        lbState.text = product.state?.name
        lbUSPrice.text = "Valor em US$ " + String(format:"%.2f", product.usPrice)
        lbTaxes.text = "Impostos em US$ " + String(format:"%.2f", (product.state?.tax)!)
        if let image = product.imageProduct as? UIImage {
            ivProduct.image = image
        } else {
            ivProduct.image = UIImage(named: "noProduct")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
