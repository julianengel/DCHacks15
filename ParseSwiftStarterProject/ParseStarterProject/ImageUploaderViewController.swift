//
//  ImageUploaderViewController.swift
//  ParseStarterProject
//
//  Created by Julian Engel on 8/2/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
class ImageUploaderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
    {
    
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
    
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func submitPressed()
    {
        let image = imageView.image
        let caption = captionTextField.text
        let category = categoryTextField.text
        let user = PFUser.currentUser()
        
        
        var post = PFObject(className: "Post")
        
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name:"image.png", data:imageData)
        imageFile.saveInBackgroundWithBlock(nil)
        
        post["caption"] = caption
        post["imageFile"] = imageFile
        post["category"] = category
        post["user"] = user
        post.saveInBackgroundWithBlock(nil)
        println("success")
        
        clean()
        tabBarController?.selectedIndex = 0
        
        
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func clean()
    {
        captionTextField.text = ""
        categoryTextField.text = ""
        imageView.image = nil
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
