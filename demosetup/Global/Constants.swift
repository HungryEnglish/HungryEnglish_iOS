//
//  Constants.swift
//  Jewlot
//
//  Created by peerbits_11 on 28/03/16.
//  Copyright © 2016 peerbits. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

//----------------------- DELEGATE --------------------------
let appInstance = UIApplication.shared.delegate as! AppDelegate
let SCREEN_SIZE = UIScreen.main.bounds

//----------------------- SCREEN --------------------------

let kMainScreen         = UIScreen.main.bounds
let kMainScreenWidth    = UIScreen.main.bounds.size.width
let kMainScreenHeight   = UIScreen.main.bounds.size.height


/***** API Credentials *****/

let liveURL : String = "http://hungryenglish.net/HungryEnglish/"
let localURL : String = "http://smartsquad.pe.hu/HungryEnglish/"

 let isLive : Bool = false // Api Environment, "Live = true, Local = false"

// Base Api URL
var baseURL: String {
    get {
        return (isLive) ? liveURL : localURL
    }
}

//------ Variable --------

let Appname = "Foodietooth"

let DeviceType = "I"

var DEVICE_ID = "djfhdskfhdkfjdkfdjdskldjkfdhk"

let statusCode = "code"

let successStatusCode  = "200"

let EncryptionKey = ""

var header: [String:String] = ["Connection":"Close"]

var header1: [String:String] = ["Content-Type":"application/json"]

let User_Details = "USER"

let Defaults = UserDefaults.standard

let SomethingWentWrong = "Something Went Wrong!"

let resend = "Re-send"

let submit = "Submit/提交"

let timerzero = "00:00"

// MARK: ------ Parameter -------


let p_audioFile = "audioFile"

let p_resume = "resume"

let p_idProof = "idProof"

let p_proImage = "proImage"

let p_address = "address"

let p_skill = "skill"

let p_station = "station"

let p_sex = "sex"

let p_mobile = "mobile"

let p_age = "age"

let p_available_time = "available_time"

let p_id = "id"

let p_username = "username"

let p_email = "email"

let p_password = "password"

let p_mob_no = "mob_no"

let p_fullName = "fullName"

let p_fullname = "fullname"

let p_role = "role"

let p_u_name = "u_name"

let p_u_pass = "u_pass"

let p_status = "status"

let p_optional_status = "optional_status"

let p_uId = "uId"

let p_link1 = "link1"

let p_link2 = "link2"

let p_link3 = "link3"

let p_link4 = "link4"

let p_link5 = "link5"

let p_link6 = "link6"

let p_lat = "lat"

let p_lng = "lng"

let p_action = "action"

let p_rate_status = "rate_status"

let p_rate_id = "rate_id"

let p_teacher_id = "teacher_id"

let p_studentId = "studentId"

let p_teacherId = "teacherId"

let p_rating = "rating"

let p_stu_id = "stu_id"

let p_nearest_railway = "nearest_railway"

let p_hourly_rate = "hourly_rate"

var lat_address = 0.0

var long_address = 0.0


//MARK:---------- ENUM ------------


// MARK: ----------- StoryBoard  -------

enum Sbname : String
{
    case Authen = "Authentication"
    case Home = "Home"
    case Setting = "Setting"
    case main = "Main"
}

enum VCname : String
{
    case login = "LoginViewController"
    case signup = "SignUpViewController"
    case completeprofile = "CompleteProfileViewController"
    case forgetpassword = "ForgotPasswordViewController"
    case countrycode = "CountryListPopupController"
    case OTPverification = "OTPVerificationViewController"
    case intro = "IntroViewController"
    case emailpopup = "EmailPopupViewController"
    case changemobpopup = "ChangeMobilePopupViewController"
    case contactus = "ContactusViewController"
    case changepwd = "ChangePwdViewController"
    case nearby = "NearbyViewController"
    case myrestaurant = "MyRestuarantViewController"
}

// MARK: -- APILINKS --

enum APIAction : String
{
    case login = "api/login.php"
    case register = "api/register.php"
    case admincount = "api/get_count.php"
    case adminstudentlist = "api/getuserbystatus.php"
    case deleteuser = "api/delete_user.php"
    case admingetimglink = "api/get_info.php"
    case adminupdateimglink = "api/add_info.php"
    case adminaccept = "api/updateStatus.php"
    case getProfile = "api/profile.php"
    case update_studprof = "api/student_profile.php"
    case update_teacher = "api/teacher_profile.php"
    case reportgenerate = "api/report_list.php"
    case getaddress = "api/get_data.php"
    case ratelist = "api/rate.php"
    case requestTeacher = "api/add_request.php"
    case getlatnlong = "api/get_users.php"
    
}

// MARK: --------- Validation Messages ---------

enum ValidMsg : String
{
    case email = "Please enter email"
    case valid_email = "Enter Valid Email/输入正确的邮箱地址"
    case password = "Please enter password"
    case valid_password = "Password must be greater than 6 characters/密码必须大于6个字符。"
   
    case countrycode = "Please select country code"
    case coming = "Coming soon..."
    case digits = " digits"
    
    case fullname = "Enter Full Name/全名"
    
    case profilepic = "Please upload your profile picture"
    
    case address = "Please enter address"
    case city = "Please select city"
    case state = "Please select state"
    case zip = "Please enter zip code"
    
    
    case country = "Please select country"
    case contactnumber = "Please enter contact number"
    case valid_Contact = "Please enter valid contact number of "
    
    case staticstrOTP = "We have sent you an sms with a code on "
    
    case otptext = "Please enter OTP code"
    case valid_otp = "Please enter valid six digit OTP code"
    
    case DOB = "Please select Date of Birth"
    case Anniversary = "Please select Anniversary"
    case validAnniversary = "Please select valid Anniversary"
    
    case emailverify = "Please Verify Your Email Address, we have sent a confirmation link to your email and then login again"
    
    case logout = "Are you sure want to logout from app?"
    
    case mergemsg = "The email you entered already exists. Do you want to merge both accounts?"
    
    case uniquecode = "Your Unique Code: "
    case enablelocsystem = "Please provide Location access permission by going into Settings"
    
    case deletepopup = "Are you sure want to delete ?"
    case acceptpopup = "Are you sure want to Accept ?"
    
    case noteacherdetailsfound = "No Teacher Detail Found"
    case nostudentfound = "No Student Detail Found"
    case alert = "Alert"
    case no = "No"
    case yes = "Yes"
    case email_lbl = "Email: "
    case mobile_lbl = "Mobile No: "
    case availability_lbl = "Availability: "
    case approved = "APPROVED"
    case pending = "PENDING"
    case title1 = "Title 1"
    case title2 = "Title 2"
    case title3 = "Title 3"
     case title4 = "Title 4"
     case title5 = "Title 5"
     case title6 = "Title 6"
    
    case link1 = "Link 1"
    case link2 = "Link 2"
    case link3 = "Link 3"
    case link4 = "Link 4"
    case link5 = "Link 5"
    case link6 = "Link 6"
    
    
    case imglink1 = "Image Link 1"
    case imglink2 = "Image Link 2"
    case imglink3 = "Image Link 3"
    
    case pleaseprovideaccesscamera = "Please provide Camera access permission by going into Settings"
    case pleaseprovideaccessgallery = "Please provide Gallery access permission by going into Settings"
    case providephotosaccess = "Please provide Photos Access"
    
    case ok = "OK"
    case pleaseenter = "Please enter "
    case camera = "Camera"
    case photolibrary = "Photo Library"
    case cancel = "Cancel"
    case cameraaccess = "Please provide camera Access"
    case detailsupdated = "Details updated successfully"
    case teacherupdated = "Teacher Details Updated Successfully"
    case filesdownloaded = "File Downloaded Successfully"
    case noteachermatchingdetailsfound = "No matching teacher detail found"
    case nodetailsfound = "No Details Found"
    
    
    case nearestrailwaystation = "Nearest Railway Station: "
    case specialskills = "Special Skill: "
    
    case cameranotfound = "Camera not found"
    case noInternetConnection = "Please check your internet connection/检查网络是否连接"
    
    case img1 = "Please select Image 1"
    case enterimglink1 = "Please enter Image Link 1"
    
    case img2 = "Please select Image 2"
    case enterimglink2 = "Please enter Image Link 2"
    
    case img3 = "Please select Image 3"
    case enterimglink3 = "Please enter Image Link 3"
    
    case entertitle1 = "Please enter Title 1"
    case entertitle2 = "Please enter Title 2"
    case entertitle3 = "Please enter Title 3"
    
    case titlelink1 = "Please enter Title Link 1"
    case titlelink2 = "Please enter Title Link 2"
    case titlelink3 = "Please enter Title Link 3"
    
    case requestteacher = "Request a Teacher/请求一位老师"
    
    case thankyouforrating = "Thank you for your valuable feedback!/谢谢你的宝贵反馈!"
    
    case requesthasbeen = "Your request has been sent to"
    
    case noteacherstudentavailable = "No Teacher and Student Available"
    case testrequestto = "Request to "
    case reportdownloaded = "Report Downloaded Successfully"
    case reenteravailbility = "Please re-enter your Availability/可用性"
    case addressvalid = "Please enter Address/地址"
    
}



// MARK : -- USERDETAILS METHOD --

func kCurrentUser() -> User?
{
    if let result = Defaults.value(forKey: User_Details)
    {
    
        let user : User = User(response: JSON(result))
        return user
    
    }
    return nil
    
}






