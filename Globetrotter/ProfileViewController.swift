//
//  ProfileViewController.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//
import UIKit
import GoogleSignIn
import Cosmos

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate {

    
    var datastring = NSDictionary()
    var dataString = NSArray()
    var camchange = Int()
    var base64String = String()
    var srching = false
    var srchCatgry = [String]()
    
    let email = UserDefaults.standard.string(forKey: "email")

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ProfileView: UIView!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileLabel: UILabel!
    @IBOutlet weak var ProfileTableView: UITableView!
    @IBOutlet var signoutView: UIView!
    @IBOutlet weak var signoutImg: UIImageView!
    @IBOutlet weak var signoutLabel: UILabel!
    
    @IBAction func signoutButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.disconnect()
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        let ViewController1 = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.present( ViewController1, animated:false, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       signoutView.layer.cornerRadius = 10
        ProfileTableView.isHidden = false
        
        self.ProfileImage.layer.cornerRadius = self.ProfileImage.frame.size.width/50
        self.ProfileImage.clipsToBounds = true

        let profile = UserDefaults.standard.url(forKey: "image")
        print("profileImage::\(profile)")
        let image2 = URL(string:(profile!.absoluteString))

       
        if let image1 = image2{
            ProfileImage.layer.cornerRadius = ProfileImage.frame.size.height / 2
            ProfileImage.clipsToBounds = true
            ProfileImage.sd_setImage( with: image1 as URL)
            ProfileImage.contentMode = .scaleAspectFit
        }
//
        let name = UserDefaults.standard.string(forKey: "fullName")
        ProfileLabel.text = "\(name!)"
        ProfileTableView.delegate = self
        ProfileTableView.dataSource = self
        self.loadData();
//        let email = UserDefaults.standard.string(forKey: "email")
//        ProfileUserMailid.text = "\(email!)"
        mainLoad()
    }
    
     func loadData() {
        ProfileTableView.reloadData()
    }
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    func mainLoad(){
        let url:URL = URL(string: "http://14.98.166.66/TravelApp/api/PostReviewAPI/GetAllPosts/")!
        let postString = "emailId=\(email!)"
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
                dataString = (jsonData?.value(forKey:"res")) as! NSArray
                print("dataString:::\(dataString)")
            }
        }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataString.count
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ProfileTableViewCell",for: indexPath) as! ProfileTableViewCell
        let reviewTitle = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"PostTitle")
        if reviewTitle is NSNull{
        }
        else{
            let title = reviewTitle as! NSString
            cell.ProfilecellreviewTitleLabel.text = title as String
        }
        
        let descriptionView = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"PostDescription")
        if descriptionView is NSNull{
            //            print("null values")
        }
        else{
            let description = descriptionView as! NSString
            cell.ProfilecellTextView.text = description as String
        }
        let commentsList = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"commentsList") as! NSArray
        cell.noofcommentslabel.text = "\(commentsList.count)"
        
        let PostLikesCount = (self.dataString.object(at: indexPath.row)as! NSDictionary).value(forKey: "PostLikesCount") as! NSNumber
        cell.nooflikeslabel.text = "\(PostLikesCount)"
        
        
        let imgstring = "http://14.98.166.66/TravelApp/UploadedImages/"
        let descImages = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"postedImages") as! NSArray
        let imageUrl = descImages.value(forKey: "ImgUrl") as! NSArray
        if imageUrl == []{
            cell.ProfilecellmainImg.image = UIImage(named: "dummyImage.jpg")
        }
        else{
            if imageUrl.count == 0{
            }else if imageUrl.count != 0{
                //                  print("i value of imageUrl::::\(i)")
                let urll = "\(imgstring)"+"\(imageUrl[0])";
                let url2 = URL(string:urll)
                print("imageUrl:::\(imageUrl[0])")
                if let urll = url2{
                    cell.ProfilecellmainImg.sd_setImage(with: urll as! URL)
                    cell.ProfilecellmainImg.contentMode = .scaleAspectFit
                }
            }
        }
        
        
        //PostLikesCount
        
        cell.ProfilecellView.layer.borderColor=UIColor.lightGray.cgColor
        cell.ProfilecellView.layer.cornerRadius = 10
        cell.ProfilecellView.layer.cornerRadius = 10
        cell.ProfilecellView.clipsToBounds = true
        cell.ProfilecellView.layer.borderWidth = 3
        cell.ProfilecellView.layer.borderColor = UIColor.white.cgColor
        
        return cell
        
    }
//    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let x = indexPath.row
        print(" k kn")
        let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController")as!DetailedViewController
        let ID = (self.dataString.object(at: x) as! NSDictionary).value(forKey: "ReviewId") as! NSNumber
        viewcontroller.reviewID = ID
        self.present(viewcontroller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}





