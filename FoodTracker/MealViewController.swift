//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Julia Castro on 7/25/16.
//  Copyright © 2016 Julia Castro. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //this value is either passed  by 'MealTableViewController' in 'prepareforSegue(_:sender:)' or constructed as part of adding a new meal
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's input through delegate callbacks
        nameTextField.delegate = self
        
        //set up views if editing an existing meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating 
        }
        
        //enable the save button only if the text field has a valid meal name 
        checkValidMealName()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //disable the save button while editing
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        //disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName() //check if the text field has text in it, which enables the save button if it does
        navigationItem.title = textField.text //sets the title of the scene to that text
    }
    
    //MARK:UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //dismiss the picker if the user cancelled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        //the info dictionary contains multiple representations of the image, and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker 
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        //depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways 
        
        let isPresentingInAddMealModel = presentingViewController is UINavigationController
        
        if isPresentingInAddMealModel {
             dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    //this method lets you configure a view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            //set the meal to be passed to MealTableViewController after the unwind segue 
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        //Hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //only allow photos to be picked not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        //make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
}

