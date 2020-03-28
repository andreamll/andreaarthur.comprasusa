//
//  ProductTableViewCell.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 20/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbUSPrice: UILabel!
    @IBOutlet weak var lbBRLPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with product: Product){
        lbName.text = product.name ?? ""
        lbState.text = product.state?.name ?? ""
        lbUSPrice.text = "US$ " + String(format:"%.2f", product.usPrice)
        lbBRLPrice.text = "R$ " + String(format:"%.2f", product.brlPrice)
        
        if let image = product.imageProduct as? UIImage {
            ivProduct.image =  image
        } else {
            ivProduct.image = UIImage(named: "noProduct")
        }
        
    }

}
