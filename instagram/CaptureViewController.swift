//
//  CaptureViewController.swift
//  instagram
//
//  Created by Daniel Margulis on 3/5/16.
//  Copyright © 2016 Daniel Margulis. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionField.placeholder = "Enter a Caption"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTakePhoto(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        pictureImageView.image = originalImage
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        let postImage = resize(pictureImageView.image!, newSize: CGSizeMake(10, 10))
        
        Post.postUserImage(postImage, withCaption: captionField.text, withCompletion: nil)
        
        pictureImageView.image = nil
        captionField.text = ""
        tabBarController?.selectedIndex = 1
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
