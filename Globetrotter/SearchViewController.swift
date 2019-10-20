//
//  SearchViewController.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.

import UIKit
import Cosmos
import SDWebImage

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var srchCatgry = [String]()
    var datastring = NSArray()
    var CountryName = [String]()
    var StateName = [String]()
    var CityName = [String]()
    var reviewTitle = NSArray()
    var postedImages = NSArray()
    var srchData = [String]()
    var emailidstring = "http://14.98.166.66/TravelApp/UploadedImages/"
    var Id = NSNumber()
    var srching = false
    var countryList = ["India"]
    
    var stateList = ["Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu & Kashmir","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","TamilNadu","Telangana","Tripura","Uttarakhand","Uttar Pradesh","West Bengal"]
    
    
    //    var viewCountry = UIView()

    @IBOutlet weak var stateView: UIView!
    
    @IBOutlet weak var stateScrl: UIScrollView!
    
    
    @IBOutlet weak var CountryPickerView: UIPickerView!
    
    
    @IBOutlet weak var StatePickerView: UIPickerView!
    
    @IBOutlet weak var CountrySearchView: UIView!
    @IBOutlet weak var StateSearchView: UIView!
    @IBOutlet weak var CountryText: UITextField!
    @IBOutlet weak var StateText: UITextField!
    @IBOutlet weak var CountryButton: UIButton!
    @IBOutlet weak var StateButton: UIButton!
    
    @IBOutlet var searchTable: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backImage: UIImageView!
    @IBAction func backActionButton(_ sender: UIButton) {
        
        let ViewController=storyboard?.instantiateViewController(withIdentifier: "TabBar")as!TabBar
        self.present(ViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTable.delegate = self
        searchTable.dataSource = self
        setUpSearchBar()
        statedrop()
        
       stateView.isHidden=true
        
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
 
   StateText.text = sender.titleLabel?.text
        
     stateView.isHidden=true
        
    }
    
    @IBAction func statedropBut(_ sender: Any) {
        
       stateView.isHidden=false
        
    }
    
    
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        var countrows : Int = countryList.count
//        if pickerView == StatePickerView{
//            countrows = self.countryList.count
//
//        }
//        return countrows
//
//
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == CountryPickerView {
//           let titleRow = countryList[row]
//            return titleRow
//        }
//        else if pickerView == StatePickerView{
//            let titleRow = stateList[row]
//            return titleRow
//        }
//        return ""
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == CountryPickerView {
//            self.CountryText.text = self.countryList[row]
//            self.CountryPickerView.isHidden = true
//        }
//        else if pickerView == StatePickerView{
//            self.StateText.text = self.stateList[row]
//            self.StatePickerView.isHidden = true
//        }
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if (textField == self.CountryText){
//            self.CountryPickerView.isHidden = false
//        }
//        else if (textField == self.StateText){
//            self.StatePickerView.isHidden = false
//        }
//    }

    
//    override func viewDidAppear(_ animated: Bool) {
//
//                var searchcountryY = 24
//
//
//
//
//        for i in 0..<countrysearchText.count{
//            //  print("\(i)")
//            let buttons = UIButton()
////            buttons.frame = CGRect(x: CountryScrollView.frame.origin.x + 2, y: searchcountryY, width: CountryScrollView.frame.width - 4, height: CGFloat(30))
//
//             buttons.frame = CGRect(x:2, y: searchcountryY, width: Int(CountryScrollView.frame.size.width) , height: Int(CountryScrollView.frame.size.height)/2 )
//
//            //            buttons.setTitle(, for: .normal)
////            buttons.addTarget(self, action: #selector(floorTypeActions(_:)), for: .touchUpInside)
//            buttons.tag = i
//            buttons.setTitle("\(countrysearchText[i])", for: .normal)
//            buttons.setTitleColor(UIColor.black, for: .normal)
//            buttons.backgroundColor = UIColor.white
//            buttons.layer.borderWidth = 0.5
//            buttons.layer.borderColor = UIColor.black.cgColor
//            CountryVieww.addSubview(buttons)
//            searchcountryY += Int(buttons.frame.origin.y) + Int(buttons.frame.size.height)
//            CountryScrollView.contentSize.height += buttons.frame.height
//
//        }
//
//    }
    
        
        
//        viewCountry.frame = CGRect(x: CountrySearchView.frame.origin.x, y: CountrySearchView.frame.origin.y + CountrySearchView.frame.size.height , width:184, height: 70)
//        //        viewGender.layer.borderWidth = 1
//        viewCountry.backgroundColor = UIColor.white
//        ScrollVIew.addSubview(viewCountry)
//
//
//
//
//
//        var searchcountryY = 24
//        for i in 0..<countrysearchText.count{
//
//            let CountryButton = UIButton()
//            CountryButton.frame = CGRect(x:2, y: searchcountryY, width: Int(viewCountry.frame.size.width) , height: Int(viewCountry.frame.size.height)/2 )
//            CountryButton.layer.borderWidth = 1
//            CountryButton.setTitle(countrysearchText[i], for: .normal)
//            CountryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//            CountryButton.layer.cornerRadius = CountryText.frame.height / 3
//            CountryButton.tag = i
//            CountryButton.setTitleColor(UIColor.black, for: .normal)
//            CountryButton.backgroundColor=UIColor.red
//            CountryButton.addTarget(self, action: #selector(CountryButton(sender:)), for: .touchUpInside)
//            viewCountry.addSubview(CountryButton)
//            searchcountryY += Int(CountryButton.frame.origin.y) + Int(CountryButton.frame.size.height)
//
//        }
//
//
//
////        searchKeyword()
//
////        SearchViewController.searchResultsUpdater = self
////        SearchViewController.hidesNavigationBarDuringPresentation = false
////        SearchViewController.dimsBackgroundDuringPresentation = false
////        searchTable.tableHeaderView = SearchViewController.searchBar
//    }
    
    func searchKeyword(){
        
        let url:URL = URL(string: "http://14.98.166.66/TravelApp/api/PostReviewAPI/SearchPosts/")!
        
//        let postString = "searchString=\(CityName)&state=\(StateName)&country=\(CountryName)"
        
        let postString = "searchString=\(searchTextFeild.text!)&state=\(StateText.text!)&country=\("India")"
//        "searchString=\(CityName)&ReviewId=\(reviewID)"
//
//        "searchString" : "golconda",
//        "state" : "Telangana",
//        "country" : "India"
        
        
        print("SearchpostString :\(postString)")
        
        
        
        
//        let postString1 = "state=\(srchCatgry)"
//        let postString2 = "country=\(srchCatgry)"
        
//        let postString = ""
        let postData:Data = postString.data(using: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let postLength:NSString = String( postData.count ) as NSString
        let request = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 3.0)
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
            // print("Response code: %ld", res?.statusCode);
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                NSLog("Response ==> %@", responseData);
            }
        }
        do {            let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
            datastring = (jsonData?.value(forKey:"res")) as! NSArray
            let reviewTitles = (datastring.value(forKey:"PostTitle"))
            if reviewTitles is NSNull{
            }
            else{
                reviewTitle = reviewTitles as! NSArray
            }
            postedImages = (datastring.value(forKey: "postedImages")) as! NSArray
            print("postedImages: \(postedImages)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchTextFeild.text!.isEmpty{
          searchTable.isHidden = true
        }else {
            searchTable.isHidden = false
        }
        return datastring.count
//        if srching{
//            searchTable.isHidden = false
//            return srchCatgry.count
//                    }
//        else{
//            return srchData.count
//        }
        //return srchData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell")as!SearchTableViewCell
        
       let PostDescription = (self.datastring.object(at:indexPath.row) as! NSDictionary).value(forKey:"PostDescription") as! NSString
        cell.titleDescription.text = PostDescription as String
        print("PostDescription:  \(PostDescription)")
        let PostTitle = (self.datastring.object(at:indexPath.row) as! NSDictionary).value(forKey:"PostTitle") as! NSString
        cell.titleReview.text = PostTitle as String
  
        let imgstring = "http://14.98.166.66/TravelApp/UploadedImages/"
        let descImages = (self.datastring.object(at:indexPath.row) as! NSDictionary).value(forKey:"postedImages") as! NSArray
        let imageUrl = descImages.value(forKey: "ImgUrl") as! NSArray
        if imageUrl == []{
            cell.searchcellImage.image = UIImage(named: "dummyImage.jpg")
        }
        else{
            if imageUrl.count == 0{
            }else if imageUrl.count != 0{
                //                  print("i value of imageUrl::::\(i)")
                let urll = "\(imgstring)"+"\(imageUrl[0])";
                let url2 = URL(string:urll)
                print("imageUrl:::\(imageUrl[0])")
                if let urll = url2{
                    cell.searchcellImage.sd_setImage(with: urll as! URL)
                    cell.searchcellImage.contentMode = .scaleAspectFit
                }
            }
        }
 //SearchCellImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ViewController1 = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        var x = indexPath.row
        if srching{
//            x =  srchData.index(of: srchCatgry[indexPath.row])!
            print("x::::\(x)")
            let ID = (self.datastring.object(at: x) as! NSDictionary).value(forKey: "ReviewId") as! NSNumber
            ViewController1.reviewID = ID
            
        }
        else {
            x = indexPath.row
            print("x::::\(x)")
            let ID = (self.datastring.object(at: x) as! NSDictionary).value(forKey: "ReviewId") as! NSNumber
            ViewController1.reviewID = ID
        }
        self.present( ViewController1, animated:false, completion:nil)
    }
    @IBOutlet var searchTextFeild: UITextField!
    @IBAction func searchTextFeild(_ sender: UITextField) {
        searchKeyword()
        searchTable.reloadData()
    }
}


extension SearchViewController: UISearchBarDelegate{
    private func setUpSearchBar(){
        
//        LocationSearchBar.delegate = self
//        countrySearchBar.delegate = self
//        StateSearchBar.delegate = self
    }
    internal func searchBar(_ srchBar: UISearchBar, textDidChange searchText: String){

        //        if countrySearchBar.text == nil || countrySearchBar.text == "" {
//            srching = false
////            view.endEditing(true)
//            searchTable.reloadData()
//        }
//        else if StateSearchBar.text == nil || StateSearchBar.text == ""{
//            srching = false
////            view.endEditing(true)
//            searchTable.reloadData()
//        }
//        else if LocationSearchBar.text == nil || LocationSearchBar.text == ""{
//            srching = false
////            view.endEditing(true)
//            searchTable.reloadData()
//        }
//        else {
//            srchData = reviewTitle as! [String]
//            srchCatgry = srchData.filter({$0.prefix(searchText.count) == searchText})
//            srching = true
//            searchTable.reloadData()
//        }
        
        
        srchData = reviewTitle as! [String]
        srchCatgry = srchData.filter({$0.prefix(searchText.count) == searchText})
    
//
//        srchCatgry = srchData.filter({$0 == LocationSearchBar.text})
//        srchCatgry = srchData.filter({$0 == StateSearchBar.text})
//        srchCatgry = srchData.filter({$0 == countrySearchBar.text})
    
        srching = true
        searchTable.reloadData()
    }
    
    
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.dismiss(animated: false, completion: nil)
//        searchTable.reloadData()
//    }
//        func updateSearchResultsForSearchController(searchController: UISearchController) {
//            postedImages.removeAll(keepCapacity: false)
//            for imageDictionary in images {
//                if imageDictionary["title"] == searchController.searchBar.text! {
//                    filteredImages += imageDictionary
//                }
//            }
//            self.searchTable.reloadData()
//        }
    
    
    
}


