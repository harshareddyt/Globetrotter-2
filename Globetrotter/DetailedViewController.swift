//
//  DetailedViewController.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit
import SDWebImage

class DetailedViewController: UIViewController {
    
    var postedPersonImage = NSString()
    var TotalRating:NSNumber!
    var click : Bool!
    var button : UIButton!
    var ID = NSNumber()
    var PostLikesCount = NSNumber()
    var currentRating = NSNumber()
    var commentCount = NSArray()
    let email = UserDefaults.standard.string(forKey: "email")
//     var commentTexts = ""
    @IBOutlet weak var tableBackView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backImg: UIImageView!
    
    @IBAction func backButton(_ sender: UIButton) {
//        self.dismiss(animated: false, completion: nil)
             let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "TabBar")as!TabBar
        self.present(viewcontroller, animated: true, completion: nil)

    }
    @IBOutlet weak var detailedReviewlabel: UILabel!
    
    var str = NSArray()
    var imageView = UIImageView()
    var back_ImageView = UIImageView()
    var backBut_DVC = UIButton()
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var commentImg: UIImageView!
    @IBAction func commentsButton(_ sender: UIButton) {
        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController")as! PopupViewController
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
        popVC.reviewID = reviewID as! Int
        tableView.reloadData()
    }
    @IBOutlet weak var noofCommentsLabel: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet var likesButton: UIButton!
    @IBAction func likesButton(_ sender: UIButton) {
        likesButton.setImage(UIImage(named: "cheart.png"), for: UIControl.State.normal)
        if click == false{
            likeImg.image = UIImage(named: "heart")
            click = true
        }
        else{
            likeImg.image = UIImage(named: "cheart")
            click = false
        }
        postLikes()
    }
    @IBOutlet weak var tableView: UITableView!
    
    var datastring = NSDictionary()
    var reviewID = NSNumber()
    let imgstring = "http://14.98.166.66/TravelApp/UploadedImages/"
    var postedImages = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//  tableBackView.layer.cornerRadius = 3
//        tableBackView.layer.masksToBounds = true
//       tableView.layer.cornerRadius = 50
//       tableView.layer.masksToBounds = true
//        likesButton.setImage(UIImage(named: "heart.png"), for: UIControl.State.normal)

        detailedLoad()
       postLikes()
 //        detailedLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//
        postedImages = datastring.value(forKey: "postedImages") as! NSArray
        
        if postedImages == []{
            print("Detail Image is NUll")
        }
        else{
            let post = postedImages as! NSArray
            let imageUrl = postedImages.value(forKey: "ImgUrl") as! NSArray
            let urll = "\(imgstring)"+"\(imageUrl[0])"
            
            let url2 = URL(string:urll)
            if let urll = url2{
                imageView.sd_setImage(with: urll as! URL)
            }
        }
        back_ImageView.frame = CGRect(x: 10, y: 30, width: 25, height: 25)
        back_ImageView.image = UIImage(named: "left-arrow.png")
        imageView.addSubview(back_ImageView)
        backBut_DVC.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
       back_ImageView.addSubview( backBut_DVC)
        backBut_DVC.addTarget(self, action: #selector(backActt(sender:)), for:.touchUpInside)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
    }

    override func viewDidAppear(_ animated: Bool) {
    
        noofCommentsLabel.text = "\(commentCount.count)"
          tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
    }
    
    
    
    
    @objc func backActt(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    func detailedLoad(){
        let url:URL = URL(string: "http://14.98.166.66/TravelApp/api/PostReviewAPI/GetPostById/")!
        let postString = "reviewId=\(reviewID)"
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
            datastring = (jsonData?.value(forKey:"res")) as! NSDictionary
            //            print(datastring)
            commentCount = datastring.value(forKey: "commentsList") as! NSArray
            
//            let commentsList = (self.datastring.object(forKey:"commentsList") as! NSDictionary).value(forKey:"commentsList") as! NSArray
          
            
     
//                        let CommentTitle = datastring.value(forKey: "commentsList")
//                        commentTexts = CommentTitle as! String
            //            let PostDescription = datastring.value(forKey: "PostDescription")!
            //            descriptionTextView.text = PostDescription as! String
            ID = datastring.value(forKey: "ReviewId") as! NSNumber
        }
    }
    func postLikes(){
        let url:URL = URL(string: "http://14.98.166.66/TravelApp//api/PostReviewAPI/PostLikes")!
        
        let postString = "LikedByEmail=\(email!)&ReviewId=\(reviewID)"
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
            let datString2 = (jsonData?.value(forKey:"info")) as! NSDictionary
            print("dataString post liking::\(datString2)")
            let likedsymbol = datString2.value(forKey: "errorMessage") as! NSString
            if likedsymbol == "Successfully Saved"{
                likesButton.setImage(UIImage(named: "cheart.png"), for: UIControl.State.normal)
                likesButton.isSelected=false
            }else{
//                likesButton.setImage(UIImage(named: "heart.png"), for: UIControl.State.normal)
                //likesButton.isSelected=true
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension DetailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        //
//        if postedImages.count == 0{
//            return 1
//        }else{
//            return 2
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedViewCell", for: indexPath) as! DetailedViewCell
            let PostTitle = datastring.value(forKey: "PostTitle") as! NSString
            cell.reviewTitleLabel.text = PostTitle as String
            let PostDescription = datastring.value(forKey: "PostDescription") as! NSString
//           currentRating
            let totalRating = datastring.value(forKey: "currentRating") as! NSNumber
            print("totalRating::\(totalRating)")
           cell.descriptionTextView.text = PostDescription as String
            str = datastring.value(forKey: "postedImages") as! NSArray
            cell.ratting.rating = Double(totalRating)
            
            
            let imgstring = "http://14.98.166.66/TravelApp/UploadedImages/"

            let PersonImg = (self.datastring.value(forKey: "PersonImg"))as!NSString
            print("profileImg;;;\(PersonImg)")
            if PersonImg == ""{
                cell.PostedPersonImage.image = UIImage(named: "person.png")
            }
            else{
                //                                print("i value of imageUrl::::\()")
                let urll = "\(imgstring)"+"\(PersonImg)";
                let url2 = URL(string:urll)
                print("imageUrl:::\(PersonImg)")
                if let urll = url2{
                    cell.PostedPersonImage.sd_setImage(with: urll as! URL)
                    cell.PostedPersonImage.contentMode = .scaleAspectFit


                }
            }
//

            
            
            
            
            return cell
            }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedViewCell1", for: indexPath)as! DetailedViewCell1
            //            cell.commentView.text = "HR"
            let commentsList = datastring.value(forKey: "commentsList") as! NSArray
            let comments = (commentsList.object(at: indexPath.row) as! NSDictionary).value(forKey: "CommentText")
            let commenting = comments as? NSString
            cell.commentsTextView.text = commenting as! String
            
            let PersonImg = (commentsList.object(at:indexPath.row) as AnyObject).value(forKey: "CommentedByImg") as! NSString
            
            
           
            if PersonImg == ""{
                cell.PlaceImage_Imageview.image = UIImage(named: "person.png")
            }
            else{
                
                let urll = "\(imgstring)"+"\(PersonImg)";
                let url2 = URL(string:urll)
                print("imageUrl:::\(PersonImg)")
                if let urll = url2{
                    cell.PlaceImage_Imageview.sd_setImage(with: urll as! URL)
                    cell.PlaceImage_Imageview.contentMode = .scaleAspectFit
                    
                    
                }
            }
             let email = (commentsList.object(at: indexPath.row) as! NSDictionary).value(forKey: "CommentByEmailID")
            cell.mailId_Lbl.text = "\(email!)"
            
            let posteddate = (commentsList.object(at: indexPath.row) as! NSDictionary).value(forKey: "CommentedOn")
            cell.postedDate_Lbl.text = "\(posteddate!)"
          
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return commentCount.count
        }
        //        return datastring.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 130
        }else
        {
            return 100
        }
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        imageView.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.size.width, height: height+20)
        
        
    }
}
