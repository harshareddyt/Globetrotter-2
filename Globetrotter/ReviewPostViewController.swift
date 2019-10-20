//
//  ReviewPostViewController.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class ReviewPostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate{
   
    var aspectRatioTextViewConstraint = NSLayoutConstraint()
    var tvHeightConstraint = NSLayoutConstraint()
    var camchange = Int()
    var imagePicker = UIImagePickerController()
    
    var countryList = ["India"]
    
     var stateList = ["Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu & Kashmir","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","TamilNadu","Telangana","Tripura","Uttarakhand","Uttar Pradesh","West Bengal"]

    @IBOutlet weak var SubmitView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryScrl: UIScrollView!
    
    @IBOutlet weak var mainScrl: UIScrollView!
    
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateScrl: UIScrollView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var reviewpostLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var uploadimageLabel: UILabel!
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var statenameTextView: UITextField!
    @IBOutlet weak var placenameTextView: UITextField!
    @IBOutlet weak var areanameTextView: UITextField!
    @IBOutlet weak var reviewtitleTextView: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var rateusLabel: UILabel!
    @IBOutlet weak var rattingstarView: UIView!
    var strBase64 = String()
    @IBAction func uploadImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.imagePicker.allowsEditing = true
            self.getImage(fromSourceType: .camera)
            self.camchange = 2
            self.uploadimageLabel.isHidden = true
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.imagePicker.allowsEditing = true
            self.getImage(fromSourceType: .photoLibrary)
            self.camchange = 1
            self.uploadimageLabel.isHidden = true
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return

        }
        if camchange == 1{
            
            galleryImage.image = selectedImage
            
            let imageData:Data = selectedImage.pngData()!
            base64String = (imageData as Data).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            print("selectedImage:\(String(describing: galleryImage.image))")
        }
        else if  camchange == 2
        {
          let orientationFixedImage = selectedImage.fixOrientation()
            galleryImage.image = orientationFixedImage
            let imageData:Data = orientationFixedImage.pngData()!
            base64String = (imageData as Data).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            //             base64String = ""
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
//        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
//            self.getImage(fromSourceType: .camera)
//        }))
//        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
//            self.getImage(fromSourceType: .photoLibrary)
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//
//    }
    @IBAction func submitButton(_ sender: UIButton) {
       if ((placenameTextView.text?.isEmpty)! &&
        (statenameTextView.text?.isEmpty)! && (areanameTextView.text?.isEmpty)! && (reviewtitleTextView.text?.isEmpty)!) &&
            (descriptionTextView.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Invalid Entry", message: "Fill all the fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if (areanameTextView.text?.isEmpty)!
        {
            let alertController = UIAlertController(title: "Failed", message: "CityName is Empty", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else if (reviewtitleTextView.text?.isEmpty)!
        {
            let alertController = UIAlertController(title: "Failed", message: "ReviewTitle is Empty", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else if (emailTextView.text?.isEmpty)!
        {
            let alertController = UIAlertController(title: "Failed", message: "Email-Id  is Empty", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else if (nameTextView.text?.isEmpty)!
        {
            let alertController = UIAlertController(title: "Failed", message: "Name is Empty", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else if (descriptionTextView.text?.isEmpty)!
        {
            let alertController = UIAlertController(title: "Failed", message: "Description is Empty", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else if (placenameTextView.text?.isEmpty)!
        {
            let alertController = UIAlertController(title: "Failed", message: "CountryName is Empty", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }else{
            postLoad()
        let x = ViewController()
        
            let alertController = UIAlertController(title: "Thank you", message: "Post Saved", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
            
            let ViewController = self.storyboard?.instantiateViewController(withIdentifier:"TabBar") as! TabBar
            
            self.present(ViewController, animated:false, completion:nil)
           
            }))
            present(alertController, animated: true, completion:nil)
        }
    }
    var dataString = NSDictionary()
    var base64String = String()
    var successmessage = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        stateView.isHidden=true
        countryView.isHidden = true
        statedrop()
        countrydrop()

        mainScrl.contentSize.height = submitButton.frame.origin.y + submitButton.frame.height + 130
       SubmitView.layer.cornerRadius = 10
       submitButton.layer.masksToBounds = true
        nameTextView.clearsOnBeginEditing=false
        emailTextView.clearsOnBeginEditing=false
        placenameTextView.clearsOnBeginEditing=false
        areanameTextView.clearsOnBeginEditing=false
        statenameTextView.clearsOnBeginEditing = false
        reviewtitleTextView.clearsOnBeginEditing=false
        nameTextView.isUserInteractionEnabled = false
        emailTextView.isUserInteractionEnabled = false
        nameTextView.isSelected = false
        emailTextView.isSelected = false
//        descriptionTextView.text = "Description"
//        descriptionTextView.textColor = UIColor.lightGray

        let name = UserDefaults.standard.string(forKey: "fullName")
        nameTextView.text = "\(name!)"
        let email = UserDefaults.standard.string(forKey: "email")
        emailTextView.text = "\(email!)"
//        descriptionTextView.isOpaque = true
        nameTextView.font = UIFont(name: "Name", size: 50)
        emailTextView.font = UIFont(name: "Name", size: 50)
        placenameTextView.font = UIFont(name: "Name", size: 50)
        statenameTextView.font = UIFont(name: "Name", size: 50)
        reviewtitleTextView.font = UIFont(name: "Name", size: 50)
        
        //        descriptionTextView.font = UIFont(name: "Name", size: 50)
        submitButton.layer.cornerRadius = 10.0
        rechebil()
        
        let profile = UserDefaults.standard.url(forKey: "image")
        print("profileImage::\(profile)")
        let image2 = URL(string:(profile!.absoluteString))
        
        let imageData:NSData = NSData.init(contentsOf: image2!)!
   strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
//        print(strBase64)
//        print("base64String;;\(strBase64)")
        
    }
    
    
    func statedrop(){
        
        stateScrl.layer.borderWidth = 0.25
        stateScrl.bounces = false
        stateScrl.backgroundColor = UIColor.white
        stateScrl.contentSize = CGSize(width: stateView.frame.size.width, height: CGFloat(stateList.count)*40)
        
        
        var b = 0
        
        var bb = 0
        
        for i in 0..<stateList.count
        {
            
            let But = UIButton()
            But.frame = CGRect(x: 0, y: b, width: Int(stateView.frame.size.width), height: 40)
            But.setTitle(stateList[i] as String , for: .normal)
            But.layer.borderWidth = 0.25
            But.alpha = 0.9
            But.setTitleColor(UIColor.black, for: .normal)
            But.tag = i
            But.addTarget(self, action: #selector(sateAction), for: .touchUpInside)
            But.backgroundColor = UIColor.white
            stateScrl.addSubview(But)
            
            
            bb = b+40
            b = bb
            
        }
        
    }
    
    @objc func sateAction(sender:UIButton)
    {
        
        statenameTextView.text = sender.titleLabel?.text
        
        stateView.isHidden=true
        
    }
    
    
    @IBAction func statedropbut(_ sender: UIButton) {
        
     stateView.isHidden=false
            
    }
    
    
    
    
    func countrydrop(){
        
        countryScrl.layer.borderWidth = 0.25
        countryScrl.bounces = false
        countryScrl.backgroundColor = UIColor.white
        countryScrl.contentSize = CGSize(width: countryView.frame.size.width, height: CGFloat(countryList.count)*40)
        
        
        var b = 0
        
        var bb = 0
        
        for i in 0..<countryList.count
        {
            
            let But = UIButton()
            But.frame = CGRect(x: 0, y: b, width: Int(countryView.frame.size.width), height: 40)
            But.setTitle(countryList[i] as String , for: .normal)
            But.layer.borderWidth = 0.25
            But.alpha = 0.9
            But.setTitleColor(UIColor.black, for: .normal)
            But.tag = i
            But.addTarget(self, action: #selector(countryAction), for: .touchUpInside)
            But.backgroundColor = UIColor.white
            countryScrl.addSubview(But)
            
            
            bb = b+40
            b = bb
            
        }
        
    }
    
    
    @objc func countryAction(sender:UIButton)
    {
        
        placenameTextView.text = sender.titleLabel?.text
        
        countryView.isHidden=true
        
    }
    
    @IBAction func countrydropbut(_ sender: UIButton) {
        
        countryView.isHidden=false

    }

    func rechebil()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            let alert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Try Again", style: .default, handler: { action in
                self.rechebil()
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        case .online(.wwan):
            print("Connected via WWAN")
        case .online(.wiFi):
            print("Connected via WiFi")
        }
    }
    
    func postLoad(){
        guard let url = URL(string: "http://14.98.166.66/TravelApp/api/PostReviewAPI/SavePost") else { return }
        let headers = [
            "Content-Type": "application/json",
            "cache-control": "no-cache",
//            "Postman-Token": "a670c020-5d3e-4e05-8535-5c8ad7c63eb2"
        ]
        let parameters = [
            "PostedByEmail": emailTextView.text!,
            "CityName": areanameTextView.text!,
            "StateName": statenameTextView.text!,
            "CountryName": placenameTextView.text!,
            "PostDescription": descriptionTextView.text!,
            //            "ReviewDescription": ReviewDescription.text!,
            "PostedByName": nameTextView.text!,
            "PostTitle": reviewtitleTextView.text!,
            //            "PostedByMobile": phoneNumber.text!,
        
            "PostedByMobile":0,
            "Images":[base64String],
            "PersonImg":"\(strBase64)",
            "imageExtension":["jpg"]]as [String : Any]
        
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                //print(response)
            }
            //  print("parameter:\(parameters)")
            if let data = data {
            do {
                    let status = Reach().connectionStatus()
                    switch status {
                    case .unknown, .offline:
                        print("Not connected")
                        
                        let alert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Try Again", style: .default, handler: { action in
                            self.rechebil()
                        })
                        alert.addAction(ok)
                        DispatchQueue.main.async(execute: {
                            self.present(alert, animated: true)
                        })
                    case .online(.wwan):
                        print("Connected via WWAN")
                    case .online(.wiFi):
                        print("Connected via WiFi")
                         let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        print("json:  \(json)")
                        let jsonmessage  = ((json as AnyObject).value(forKey:"info")) as! NSDictionary
                        self.successmessage = jsonmessage.value(forKey: "errorMessage") as! String
                        
                        let message = "Emailid already exists."
                        
                        if self.successmessage.isEqual(message) {
                            
                            
                            
                            DispatchQueue.main.async {
                        
                                IJProgressView.shared.hideProgressView()
                               
                            }
                          
                        } else {
                            DispatchQueue.main.async {
                                IJProgressView.shared.hideProgressView()
                            }
                            
                            
                            let alert = UIAlertController(title: "", message: "Thanks! Your Account has been succesfully created.", preferredStyle: .alert)
                            
                            let ok = UIAlertAction(title: "Please Login", style: .default, handler: { action in
                                
                                DispatchQueue.main.async {
                                    IJProgressView.shared.hideProgressView()
                                }
                                
                                let view = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
                                //
                                self.present(view, animated: false,completion: nil)
                                
                            })
                            
                            alert.addAction(ok)
                            
                            
                            DispatchQueue.main.async(execute: {
                                
                                self.present(alert, animated: true)
                                
                            })
                            
                            
                        }
                        
                        
                    }
                } catch {
                    
                    print(error)
                }
                }
            }
            .resume()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let contentSize = self.nameTextView.sizeThatFits(self.nameTextView.bounds.size)
        var frame = self.nameTextView.frame
        frame.size.height = contentSize.height
        self.nameTextView.frame = frame
        
        aspectRatioTextViewConstraint = NSLayoutConstraint(item: self.nameTextView, attribute: .height, relatedBy: .equal, toItem: self.nameTextView, attribute: .width, multiplier: nameTextView.bounds.height/nameTextView.bounds.width, constant: 1)
        self.nameTextView.addConstraint(aspectRatioTextViewConstraint)
        
    }
}
extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}

