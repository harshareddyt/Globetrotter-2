//
//  PopupViewController.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit
import Cosmos
class PopupViewController: UIViewController {
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messagelabel: UILabel!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet var cosmosView: CosmosView!
   
    var reviewID:Int!
    var datastring = NSDictionary()
    let email = UserDefaults.standard.string(forKey: "email")
    var strBase64 = NSString()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.popupView.layer.cornerRadius = 50.0
        self.popupView.clipsToBounds = true
        cosmosView.settings.fillMode = .full

    }

    @IBAction func RateButton(_ sender: UIButton) {
        if (TextField.text?.isEmpty)! && cosmosView.rating.isZero {
            let alertController = UIAlertController(title: "Post Failed", message: "Empty fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
            }
        else if(TextField.text?.isEmpty)! || cosmosView.rating.isZero{
            let alertController = UIAlertController(title: "Post Failed", message: "Empty fields", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }else{
            postLoading()
            saveRate()
//            let alertController = UIAlertController(title: "Comments alert", message: "Thank you for the comments", preferredStyle: UIAlertController.Style.alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{action in
            
//            }))
//            present(alertController, animated: true, completion: nil)
//            self.commentTextField = TextField.text!
//            let view = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
//            view.commentTexts = commentTextField
            
            }
        
        
       
    }
        func saveRate(){
            let url:URL = URL(string: "http://14.98.166.66/TravelApp/api/PostReviewAPI/PostRating/")!
//            let email = UserDefaults.standard.string(forKey: "email")
            let postString = "RatedByEmail=\(email!)&RatingNumber=\(cosmosView.rating)&ReviewId=\(reviewID!)"
            print("postString:::\(postString)")
            let postData:Data = postString.data(using: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
            let postLength:NSString = String( postData.count ) as NSString
            let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            var reponseError: NSError?
            var response: URLResponse?
            var urlData: Data?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
            } catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            if ( urlData != nil ) {
                let res = response as! HTTPURLResponse!;
                print("Response code: %ld", res?.statusCode);
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    NSLog("Response ==> %@", responseData);
                }
            }
            do {
                let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
                print("jsonData for save Rate::::\(jsonData)")
                let datString1 = (jsonData?.value(forKey:"info")) as! NSDictionary
                
//                let info = (jsonData?.value(forKey:"info")) as! NSDictionary
                let errorMessage = datString1.value(forKey: "errorMessage") as! NSString
                if errorMessage.isEqual("Successfully Saved"){
                    let view = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
                    view.reviewID = reviewID! as NSNumber
                     view.viewDidLoad()
                    self.present(view,animated: false,completion: nil)
                   
                
                }
                
//                print("dataString::\(datString1)")
            }
        }
        func postLoading(){
            let profile = UserDefaults.standard.url(forKey: "image")
            print("profileImage::\(profile)")
            let image2 = URL(string:(profile!.absoluteString))
            
            let imageData:NSData = NSData.init(contentsOf: image2!)!
            strBase64 = imageData.base64EncodedString(options: .lineLength64Characters) as NSString
            let url:URL = URL(string: "http://14.98.166.66/TravelApp/2api/PostReviewAPI/PostComment/")!
            let headers = [
                "Content-Type": "application/json",
//                "User-Agent": "PostmanRuntime/7.11.0",
//                "Accept": "*/*",
//                "Cache-Control": "no-cache",
//                "Postman-Token": "fceef824-c66f-4b10-9f5a-330657732c56,b2741092-74f7-4123-9227-bb6b0cd159f9",
//                "Host": "14.98.166.66",
//                "accept-encoding": "gzip, deflate",
//                "content-length": "103",
//                "Connection": "keep-alive",
                "cache-control": "no-cache"
            ]
            let parameters = [
                "CommentedByEmail": "\(email!)",
                "CommentText": "\(TextField.text!)",
                "ReviewId": "\(reviewID!)",
                "ImageURL" : "\(strBase64)"
                ] as [String : Any]
            
            let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://14.98.166.66/TravelApp/api/PostReviewAPI/PostComment/")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data


            let postLength:NSString = String( postData.count ) as NSString
           
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            
            var reponseError: NSError?
            var response: URLResponse?
            var urlData: Data?
            do {
                urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
            } catch let error as NSError {
                reponseError = error
                urlData = nil
            }
            if ( urlData != nil ) {
                let res = response as! HTTPURLResponse!;
                print("Response code: %ld", res?.statusCode);
                if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                    NSLog("Response ==> %@", responseData);
                }
            }
            do {
                let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
                print("jsonData::\(String(describing: jsonData))")
                let info = (jsonData?.value(forKey:"info")) as! NSDictionary
                let errorMessage = info.value(forKey: "errorMessage") as! NSString
                if errorMessage.isEqual("Successfully Saved"){
                    let view = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
                    view.reviewID = reviewID as! NSNumber
                    self.present(view,animated: false,completion: nil)
                    view.tableView.reloadData()
                }
//                print("dataString::\(datString1)")
            }
    }
    //
    //
    //        let view = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController")
    //            as! DetailedViewController
    //        self.present(view, animated: false,completion: nil)

        @IBAction func CancelButton(_ sender: UIButton) {
        let view = storyboard?.instantiateViewController(withIdentifier: "TabBar")
            as! TabBar
        self.present(view, animated: false,completion: nil)
    }
}
