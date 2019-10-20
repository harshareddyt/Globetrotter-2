//
//  ViewController.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//
import UIKit
import SDWebImage

var imagess = [UIImage]()
let email = UserDefaults.standard.string(forKey: "email")
var reviewID = NSNumber()
var click : Bool!
var button : UIButton!

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
        var profileimg = NSString()
        var dataString = NSArray()
        var profilename = NSString()
        //    var descriptionTxt = NSString()
        //    var cellimg = NSString()
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataString.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:"HomeTableViewCell",for: indexPath) as!HomeTableViewCell
            cell.likeButton.addTarget(self, action: #selector(likeButton), for: .touchUpInside)
           
            
           
            //        cell.nameLabel?.text = namesLabel[indexPath.item]
            
            //        cell.cellImg.layer.cornerRadius = 5.0
            
            // cell.cellImg.layer.cornerRadius = self.mainImg.frame.size.width / 12
            //        cell.cellImg.clipsToBounds = true
            
            
            //        cell.cellImg.image = UIImage(named: mainImg[indexPath.item])
            //        cell.profileImg.image = UIImage(named: profileImages[indexPath.item])
            //        cell.profileImg.layer.cornerRadius = 12.0
            //        cell.profileImg.clipsToBounds = true
            
            //       cell.textField.text = cellTripDescription[indexPath.row]
            //        cell.nameLabel.text = namesLabel[indexPath.row]
            //        cell.datesLabel.text = dates[indexPath.row]
            //        cell.cellImg.image = UIImage(named: descImages[indexPath.item])
            
            let reviewTitle = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"PostTitle")
            if reviewTitle is NSNull{
                print("null values")
            }
            else{
                var title = reviewTitle as! NSString
                cell.TextField1.text = reviewTitle as? String
            }
//            if(reviewTitle.done){
//                cell.butImage.isHidden = false
//            }
//
            let descriptionView = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"PostDescription")
            if descriptionView is NSNull{
                //            print("null values")
            }
            else{
                var description = descriptionView as! NSString
                cell.textField.text = descriptionView as? String
            }
            let postname = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"PostedByName")
            if postname is NSNull{
                //            print("null values")
            }
            else{
                var postedname = postname as! NSString
                cell.nameLabel.text = postname as? String
            }
            let commentsList = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"commentsList") as! NSArray
            cell.noofcomments.text = "\(commentsList.count)"
             let imgstring = "http://14.98.166.66/TravelApp/UploadedImages/"
            let PersonImg = (self.dataString.object(at: indexPath.row)as!NSDictionary).value(forKey: "PersonImg")as!NSString
            print("profileImg;;;\(PersonImg)")
            if PersonImg == ""{
                cell.profileImg.image = UIImage(named: "person.png")
            }
            else{
//                                print("i value of imageUrl::::\()")
                    let urll = "\(imgstring)"+"\(PersonImg)";
                    let url2 = URL(string:urll)
                    print("imageUrl:::\(PersonImg)")
                    if let urll = url2{
                        cell.profileImg.sd_setImage(with: urll as! URL)
                        cell.profileImg.contentMode = .scaleAspectFit
                 
               
            }
            }
            let descImages = (self.dataString.object(at:indexPath.row) as! NSDictionary).value(forKey:"postedImages") as! NSArray
            let imageUrl = descImages.value(forKey: "ImgUrl") as! NSArray
            
            if imageUrl == []{
                cell.cellImg.image = UIImage(named: "dummyImage.jpg")
            }
            else{
                if imageUrl.count == 0{
                }else if imageUrl.count != 0{
//                  print("i value of imageUrl::::\(i)")
                    let urll = "\(imgstring)"+"\(imageUrl[0])";
                    let url2 = URL(string:urll)
                    print("imageUrl:::\(imageUrl[0])")
                    if let urll = url2{
                        cell.cellImg.sd_setImage(with: urll as! URL)
                        cell.cellImg.contentMode = .scaleAspectFit
                    }
                }
            }
            return cell
        }
        
        func mainDataLoad(){
            
            let url:URL = URL(string: "http://14.98.166.66/TravelApp/api/PostReviewAPI/GetALL")!
            let email = UserDefaults.standard.string(forKey: "email")
            let postString = ""
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
                    let responseData:NSString  = NSString(data:urlData!,    encoding:String.Encoding.utf8.rawValue)!
                    NSLog("Response ==> %@", responseData);
                }
            } 
            do {
                let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
                dataString = (jsonData?.value(forKey:"res")) as! NSArray
            } 
        }
        
        func postLiked(){
            let url:URL = URL(string:"http://14.98.166.66/TravelApp/api/PostReviewAPI/GetallLikes")!

            let postString = "LikedByEmail=\(email!)"
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
                let datString2 = (jsonData?.value(forKey:"LikedPostsReviewID")) as! NSArray
//                print("dataString post liking::\(datString2)")
//                let likedsymbol = datString2.value(forKey: "errorMessage") as! NSString
//                if likedsymbol == "Successfully Saved"{
//                    likesButton.setImage(UIImage(named: "cheart.png"), for: UIControl.State.normal)
//                    likesButton.isSelected=false
//                }else{
//                    likesButton.setImage(UIImage(named: "heart.png"), for: UIControl.State.normal)
//                    likesButton.isSelected=true
//                }
            }
        }
       
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let x = indexPath.row
            print(" k kn")
            let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController")as!DetailedViewController
            let ID = (self.dataString.object(at: x) as! NSDictionary).value(forKey: "ReviewId") as! NSNumber
            viewcontroller.reviewID = ID
            self.present(viewcontroller, animated: true, completion: nil)
            //        viewcontroller.TripDescTextView.text = cellTripDescription[x]
            //
            //        viewcontroller.profileImage.image = UIImage(named:profileImages[x])
            //
            //       viewcontroller.profileNameLabel.text = namesLabel[x]
            //
            //      viewcontroller.dateLabel.text = dates[x]
            //        viewcontroller.cellImage.image = UIImage(named: descImages[x])
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 412
    }
        @IBOutlet weak var travellingtoLabel: UILabel!
        @IBAction func searchButton(_ sender: UIButton) {
            let view = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            self.present(view, animated: false,completion: nil)
        }
        
        
        @IBOutlet weak var searchTextField: UITextField!
        @IBOutlet weak var SearchView: UIView!
        @IBOutlet weak var TableView: UITableView!
        @IBOutlet weak var searchIconImg: UIImageView!
        func loadData() {
            // code to load data from network, and refresh the interface
            TableView.reloadData()
        }
        @objc func likeButton(_ sender: UIButton) {
            if click == false{
                sender.setImage(UIImage(named: "heart.png"), for: .normal)
//                sender.image = UIImage(named: "heart.png")
                click = true
            }
            else{
                sender.setImage(UIImage(named: "cheart.png"), for: .normal)
//                sender.image = UIImage(named: "cheart.png")
                click = false
                postLiked()
            }
        }
        override func viewDidLoad() {
                    super.viewDidLoad()
            //        self.cmtButton.layer.cornerRadius = 12.0
            //        self.cmtButton.clipsToBounds = true
            //
            //        self.cmt3Button.layer.cornerRadius = 12.0
            //        self.cmt3Button.clipsToBounds = true
            //
            //        self.cmt2Button.layer.cornerRadius = 12.0
            //        self.cmt2Button.clipsToBounds = true
            //
            //        self.namesLabel.layer.shadowRadius = 5.0
            //        self.namesLabel.layer.borderWidth = 1
            //        self.namesLabel.layer.shadowColor = UIColor.gray.cgColor
            //        self.namesLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            //        self.namesLabel.layer.shadowOpacity = 1.0
            self.loadData();
             mainDataLoad()
//            TableView.reloadData()
            postLiked()

        }
//        override func prepareForReuse() {
//            // invoke superclass implementation
//            super.prepareForReuse()
//            
//            // reset (hide) the checkmark label
//            self.profileimg.isHidden = true
//            
//        }
  }
    
