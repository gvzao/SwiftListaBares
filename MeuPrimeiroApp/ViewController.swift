//
//  ViewController.swift
//  MeuPrimeiroApp
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nomeBarText: UITextField!
  

    @IBOutlet weak var imageAB: UIImageView!
    @IBOutlet weak var buttonMapa: UIButton!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var enderecoText: UITextField!
    
    @IBOutlet weak var telefoneText:UITextField!
  
    @IBOutlet weak var ratingBar: RatingBar!
    @IBOutlet weak var avalieText: UITextField!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var bar: Bar?
    @IBOutlet weak var imageView: UIImageView!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        let name = nomeBarText.text ?? ""
        let photo = imageView.image
        let rating = ratingBar.rating
        let endereco = enderecoText.text ?? ""
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude:0)
        // Set the meal to be passed to BarTableViewController after the unwind segue.
        bar = Bar(name: name, endereco: endereco, photo: photo, rating: rating, coordinate: coordinate)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        nomeBarText.delegate = self
        //Declarando componentes no bar
        if let bar = bar {
            navigationItem.title = bar.name
            nomeBarText.text   = bar.name
            imageView.image = bar.photo
            ratingBar.rating = bar.rating
        }
        
        enderecoText.delegate = self
        updateSaveButtonState()
               
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nomeCampo : String!
        switch textField {
        case nomeBarText:
            nomeCampo = "Bar: "
            break
        case enderecoText:
            nomeCampo = "Endereco: "
            break
        case telefoneText:
            nomeCampo = "Telefone: "
            break
        case avalieText:
            nomeCampo = "Avalie: "
            break
        default:
            break
        }
    
        let digitado = textField.text!
        let message = nomeCampo + digitado
        print(message)
        
        return true;
    }
    
    
    @IBAction func imageAction(_ sender: Any) {
        func showAlert() {
            
            let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
                self.getImage(fromSourceType: .camera)
            }))
            alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
                self.getImage(fromSourceType: .photoLibrary)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        showAlert()
        //get image from source type
    }
    func getImage(fromSourceType sourceType:
        UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage;
        imageView.image = image;
        picker.dismiss(animated: true, completion:nil)
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        nomeBarText.text = textField.text
        saveButton.isEnabled = false
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nomeBarText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
}
