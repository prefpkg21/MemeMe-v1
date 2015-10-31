//
//  ViewController.swift
//  MemeMe v1.0
//
//  Created by BLAKE IVY on 10/29/15.
//  Copyright © 2015 Blake Ivy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    var imagePicker: UIImagePickerController?
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)!,
        NSStrokeWidthAttributeName: NSNumber(double: 2.0)
    ]
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        //TODO: Restore app to launch state
        imageView.image = nil
        topTextField.text    = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    @IBAction func share(sender: UIBarButtonItem) {
        let shareViewController = UIActivityViewController(activityItems: ["UIImage"], applicationActivities: nil)
        presentViewController(shareViewController, animated: true, completion: nil)
    }
    
    @IBAction func selectFromCamera(sender: UIBarButtonItem) {
        pickImage(.Camera)
    }
    @IBAction func selectFromAlbum(sender: UIBarButtonItem) {
        pickImage(.PhotoLibrary)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageView.image = pickedImage
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        imagePicker = nil
        shareButton.enabled = true
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pickImage(source: UIImagePickerControllerSourceType) {
        if self.imageView.isAnimating(){self.imageView.stopAnimating()}
        
        if (imagePicker == nil){
            imagePicker = UIImagePickerController()
        }
        imagePicker?.sourceType = source
        imagePicker?.delegate = self
        imagePicker?.modalPresentationStyle = UIModalPresentationStyle.CurrentContext

        presentViewController(imagePicker!, animated: true, completion: nil)
    }
}
