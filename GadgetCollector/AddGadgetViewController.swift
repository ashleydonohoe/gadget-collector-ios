//
//  AddGadgetViewController.swift
//  GadgetCollector
//
//  Created by Gabriele on 5/20/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class AddGadgetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var gadgetImageView: UIImageView!
    @IBOutlet weak var gadgetTitleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var gadget: Gadget? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if gadget != nil {
            gadgetImageView.image = UIImage(data: gadget?.image as! Data)
            gadgetTitleTextField.text = gadget?.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
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
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(gadget!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }

    @IBAction func addTapped(_ sender: Any) {
        if gadgetImageView.image != nil && gadgetTitleTextField.text != "" {
            if gadget != nil {
                gadget!.title = gadgetTitleTextField.text
                gadget!.image = UIImagePNGRepresentation(gadgetImageView.image!)! as NSData
            } else {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let gadget = Gadget(context: context)
                gadget.title = gadgetTitleTextField.text
                gadget.image = UIImagePNGRepresentation(gadgetImageView.image!)! as NSData
            }
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
}
