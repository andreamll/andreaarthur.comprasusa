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
    @IBOutlet weak var btAddEditProduct: UIButton!
    @IBOutlet weak var btProduct: UIButton!
    
    var product: Product!
    lazy var pickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    var statesManager = StatesManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statesManager.loadStates(with: context)
        prepareStateTextField()
        
        if product != nil {
            //Edicao
            title = "Editar Produto"
            btProduct.setTitle("ALTERAR", for: .normal)
            tfName.text = product.name
            if let state = product.state, let index = statesManager.states.index(of: state) {
                tfState.text = state.name
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            ivProduct.image = product.imageProduct as? UIImage
            if product.imageProduct != nil{
                btAddEditProduct.setTitle(nil, for: .normal)
            }
            tfUSPrice.text = String(format:"%.2f", product.usPrice)
            swCreditCard.isOn = product.useCreditCard
        }
        
    }
    
    func prepareStateTextField(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "bag")
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        tfState.inputView = pickerView
        tfState.inputAccessoryView = toolbar
    }
    
    @objc func cancel() {
        tfState.resignFirstResponder()
    }
    
    @objc func done(){
        
        tfState.text = statesManager.states [pickerView.selectedRow(inComponent: 0)].name
        
        cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statesManager.loadStates(with: context)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor(named: "bag")
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addEditImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar imagem", message: "De onde você quer escolher a imagem?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { (action: UIAlertAction) in self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de fotos", style: .default) { (action: UIAlertAction) in self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addEditProduct(_ sender: UIButton) {
        
        if product == nil {
            product = Product(context: context)
        }
        
        product.name = tfName.text
        product.usPrice = Double(tfUSPrice.text!) ?? 0
        product.useCreditCard = swCreditCard.isOn
        
        if !tfState.text!.isEmpty{
            let state = statesManager.states[pickerView.selectedRow(inComponent: 0)]
            product.state = state
        }
        product.imageProduct = ivProduct.image
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension ProductAddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesManager.states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = statesManager.states[row]
        return state.name
    }
}

extension ProductAddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        ivProduct.image = image
        btProduct.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}





