//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Capt. Ihsan on 1/16/17.
//  Copyright © 2017 Erlangga. All rights reserved.
//

import UIKit
import os.base
import os.activity

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    // passed by tableViewController for adding new meal
    var meal:Meal?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    func textFieldDidEndEditing(textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        nameTextField.delegate = self
        updateSaveButtonState()
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

    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // kalo segue menggunakan modal
//         dismissViewControllerAnimated(true, completion: nil)
        // kalo segue menggunakan push
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        // mendeteksi segue yang dituju
        guard let button = sender as? UIBarButtonItem where button === saveButton else {
            fatalError("The save button was not pressed, cancelling")
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    // MARK: Private Methods
    private func updateSaveButtonState(){
        // disable tombol save kalo nilai textfield kosong
        
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
}

