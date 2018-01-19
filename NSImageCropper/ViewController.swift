//
//  ViewController.swift
//  NSImageCropper
//
//  Created by Nikesh Jha on 1/19/18.
//  Copyright © 2018 Javra Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    var croppedImage: UIImage?
    var selectedImage: UIImage?
    let picker = UIImagePickerController()
    @IBOutlet weak var displayImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func selectImageToCrop(_ sender: Any) {
        
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        self.present(picker, animated: true) {
            print("")
        }
    }
    
    
   
    
    //MARK: - ImagePickerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]){
        picker.dismiss(animated: true, completion: nil)
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        displayImgView.contentMode = .scaleAspectFit //3
        displayImgView.image = selectedImage //4
        
        
        //launch the image cropper controller
        let imageCropperVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageCropperViewController") as! ImageCropperViewController
        imageCropperVC.delegate = self
        imageCropperVC.image = selectedImage!
        
        self.navigationController?.pushViewController(imageCropperVC, animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
}


//MARK:- ImageCropperDelegate  methods
extension ViewController: ImageCropperDelegate {
    func didCropImage(croppedImage: UIImage) {
        self.croppedImage = croppedImage
        displayImgView.image = croppedImage
    }
}
