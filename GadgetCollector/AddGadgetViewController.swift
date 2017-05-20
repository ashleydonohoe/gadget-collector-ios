//
//  AddGadgetViewController.swift
//  GadgetCollector
//
//  Created by Gabriele on 5/20/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class AddGadgetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var gadgetImageView: UIImageView!
    @IBOutlet weak var gadgetTitleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        gadgetImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if gadgetImageView.image != nil && gadgetTitleTextField.text != "" {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let gadget = Gadget(context: context)
            gadget.title = gadgetTitleTextField.text
            gadget.image = UIImagePNGRepresentation(gadgetImageView.image!)! as NSData
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            navigationController?.popViewController(animated: true)
        }
    }
}
