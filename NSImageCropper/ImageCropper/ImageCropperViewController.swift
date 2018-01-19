//
//  ImageCropperViewController.swift
//  ImageCropper
//
//  Created by Aatish Rajkarnikar on 10/4/16.
//  Copyright © 2016 iOSHub. All rights reserved.
//

import UIKit


protocol ImageCropperDelegate {
    func didCropImage(croppedImage: UIImage)
}

class ImageCropperViewController: UIViewController, UIScrollViewDelegate {

    var delegate: ImageCropperDelegate?
    
    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 10.0
        }
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cropAreaView: CropAreaView!
    var image: UIImage = UIImage()
    
    var cropArea:CGRect{
        get{
            let factor = imageView.image!.size.width/view.frame.width
            let scale = 1/scrollView.zoomScale
            let imageFrame = imageView.imageFrame()
            let x = (scrollView.contentOffset.x + cropAreaView.frame.origin.x - imageFrame.origin.x) * scale * factor
            let y = (scrollView.contentOffset.y + cropAreaView.frame.origin.y - imageFrame.origin.y) * scale * factor
            let width = cropAreaView.frame.size.width * scale * factor
            let height = cropAreaView.frame.size.height * scale * factor
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    

    
    @IBAction func crop(_ sender: UIButton) {
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: cropArea)
        let croppedImage = UIImage(cgImage: croppedCGImage!)
//        imageView.image = croppedImage
        scrollView.zoomScale = 1
        delegate?.didCropImage(croppedImage: croppedImage)
        print("cropped successfully")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}


class CropAreaView: UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }
    
}
