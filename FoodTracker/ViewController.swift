//
//  ViewController.swift
//  FoodTracker
//
//  Created by Capt. Ihsan on 1/16/17.
//  Copyright © 2017 Erlangga. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var mealNameLabel: UILabel!

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func textFieldDidEndEditing(textField: UITextField) {
        mealNameLabel.text = nameTextField.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { fatalError("Expected a dictionary containing an image but was provided the following: \(info)")}
        
        photoImageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }

}

