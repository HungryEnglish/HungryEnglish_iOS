//
//  Utilities.swift
//  TFMS Driver
//
//  Created by : Manoj
//  Created Date : 18/01/16
//

import Foundation
import UIKit
//import TTGSnackbar
//import Toast_Swift
import Toaster

class Utilities {
    
    class func viewController(name: String, onStoryboard storyboardName: String) -> UIViewController
    {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name) as UIViewController
    }
    
    class func getFormatedTimeInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "hh:mm a"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func localDateFromUTC(timestamp: Int64) -> NSDate {
        let utcDate = NSDate(timeIntervalSince1970: Double(timestamp))
        let localTimeZoneInSeconds : Double = 0.0//Double(NSTimeZone.localTimeZone().secondsFromGMT)
        let localDate = utcDate.addingTimeInterval(localTimeZoneInSeconds)
        return localDate
    }
    
    class func timeFormatFromSecondsintwenty (seconds : Double) -> String {

        let seconds = Int(seconds)
       // let sec: Int = seconds % 60
        let minutes: Int = (seconds / 60) % 60
        let hours: Int = seconds / 3600
        
        return (String(format: "%02d:%02d", hours, minutes))
    }
    class func timeFormatFromSeconds (seconds : Double) -> String {

        let seconds = Int(seconds)
        let sec: Int = seconds % 60
        let minutes: Int = (seconds / 60) % 60
        let hours: Int = seconds / 3600
        
        print(String(format: "%02d:%02d:%02d", hours, minutes, sec))
        
        if hours == 12
        {
            return (String(format:"%02d:%02d PM", hours, minutes))
            
        }else if hours > 12
        {
            if hours == 24
            {
                return (String(format:"00:%02d AM", minutes))
                
            }else{
                return (String(format:"%02d:%02d PM", hours - 12 , minutes))
            }
        }else{
            
            return (String(format:"%02d:%02d AM", hours , minutes))
        }
        
    }

    
    class func ConvertDateToUTC(date: NSDate) -> NSDate {
        
        let timeZoneOffset = Double(NSTimeZone.local.secondsFromGMT())// as TimeInterval
        let interval = date.timeIntervalSince1970 + timeZoneOffset
        return Date(timeIntervalSince1970: interval) as NSDate
    }

    
    // MARK: - Validation -
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        if result == false
        {
            // showMessage(text: ValidMsg.valid_email.rawValue)
        }
        return result
        
    }
    

    
    class func getTimeStampInTimeStamp(datetimestamp : NSDate) -> Int64
    {
        let calender = NSCalendar.current
        
        let Cur_Date = calender.startOfDay(for: datetimestamp as Date)
        
        print(Cur_Date)
        
        print(Cur_Date.timeIntervalSince1970.description)
        
        return Int64(Cur_Date.timeIntervalSince1970)
    }
    
    class func daysBetweenDates(estiDate : Date,endDate: Date) -> Int
    {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: estiDate) //Date())
        let date2 = calendar.startOfDay(for: endDate)
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }
    
    class func getFormatedDateInStringDashed(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd/MM/YYYY"
        return fmDate.string(from: dateTime as Date)
    }

    
    class func getFormatedDateInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "YYYY-MM-dd"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedmonthDateInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd MMM"//"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedDateValueInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd"//"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedMonthValueInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "MMM"//"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedTransactionDateInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd MMM hh:mm a"//"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedmonthStringDateInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd/MM"//"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedDateYearInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd MMM, YYYY" //"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }

    
    class func isValidPassword(testStr:String) -> Bool {
        
        if (testStr.characters.count >= 6) && (testStr.characters.count <= 12) {
            return true
        }else{
            showMessage(text: ValidMsg.valid_password.rawValue)
            return false
        }
    }
    
    class func validatemobilenumber(textfield : UITextField)  -> Bool
    {
        return true
    }
    
    
    class func validateemptyfield(textfield : UITextField) -> Bool
    {
        if (textfield.text?.isEmpty)!
        {
            return true
        }
        return false
    }
    
  
    class func isValidUser(textfield : UITextField)  -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", "^\\w+( +\\w+)*$")
        let result = passwordTest.evaluate(with: textfield.text)
        if result == false
        {
            showMessage(text: "")
        }
        return result
    }
    
    class func isValidRegex(testStr:String , regex: String) -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = passwordTest.evaluate(with: testStr)
        return result
        
    }
    
    
    class func trimWhiteSpaces(text : NSString)-> NSString
    {
        return text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
    }

    //  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
    
    class func resize(_ image: UIImage) -> UIImage {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 1024.0
        let maxWidth: Float = 720.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        let imageData: Data? = UIImageJPEGRepresentation(img!, CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    


    
//
//    
//    class func timestampSince1970FromDate(date: NSDate) -> Double {
//        return date.timeIntervalSince1970
//    }
//    
//    class func getFormatedDateTimeInString(dateTime : NSDate) -> String {
//        let fmDate = NSDateFormatter()
//        fmDate.dateFormat = "dd MMM YYYY"
//        return fmDate.stringFromDate(dateTime)
//    }
//    
//    class func getFormatedDateInString(dateTime : NSDate) -> String {
//        let fmDate = NSDateFormatter()
//        fmDate.dateFormat = "dd/MM/YYYY"
//        return fmDate.stringFromDate(dateTime)
//    }
//    
//    class func getTimeInString(dateTime : NSDate) -> String {
//        let fmDate = NSDateFormatter()
//        fmDate.dateFormat = "HH:mm"
//        fmDate.timeZone = NSTimeZone(forSecondsFromGMT: 0)
//        return fmDate.stringFromDate(dateTime)
//    }
//    

    class func showMessage(text:String)
    {
        
       
        ToastView.appearance().font = UIFont(name: "Poppins-Regular", size: 13.0)
        Toast(text : text).show()
        
    }

    
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    
    class func resizeImage(image: UIImage) -> UIImage{
        let size = image.size
        let targetSize : CGSize = CGSize(width: 500, height: 500)
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
    
    class func BorderForCellView(view : UIView)
    {
        //        view.layer.cornerRadius = 8.0
        //        view.layer.borderColor = UIColor(red: 228.0/255.0, green: 234.0/255.0, blue: 238.0/255.0, alpha: 1.0).cgColor
        //        view.layer.borderWidth = 1.5
        //        view.clipsToBounds = true
        
        let shadowView = view//UIView(frame: view.frame)
        shadowView.layer.shadowColor = UIColor(red: 64.0/255.0, green: 74.0/255.0, blue: 92.0/255.0, alpha: 1).cgColor
        
        shadowView.layer.shadowOffset = CGSize()
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 2
        shadowView.layer.cornerRadius = 10.0
        //shadowView.clipsToBounds = true
        
        let view = UIView(frame: shadowView.bounds)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        
        //shadowView.addSubview(view)
        view.sendSubview(toBack: shadowView)//(toFront: view)
        //superview.addSubview(shadowView)
        
    }
    
    class func BorderToInnerview(view: UIView, cornerrounds : [UIRectCorner]) -> CALayer
    {
        let path = UIBezierPath(roundedRect:view.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 5, height:  5))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath

        return maskLayer
        
    }
    
    class func BorderForView(view : UIView)
    {
        
        
        let shadowView = view//UIView(frame: view.frame)
        shadowView.layer.shadowColor = UIColor.init(colorLiteralRed: 64.0/255.0, green: 74.0/255.0, blue: 92.0/255.0, alpha: 1).cgColor
        
        shadowView.layer.shadowOffset = CGSize()
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 2
        shadowView.layer.cornerRadius = 10.0
        //shadowView.clipsToBounds = true
        
        let view = UIView(frame: shadowView.bounds)
   
        view.layer.cornerRadius = 10.0
        view.layer.borderColor = UIColor(red: 228.0/255.0, green: 234.0/255.0, blue: 238.0/255.0, alpha: 1.0).cgColor
        view.layer.borderWidth = 2.0
        view.clipsToBounds = true
        
    }
    
    class func BorderForTextFieldView(view : UIView)
    {
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(colorLiteralRed: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1).cgColor
        view.layer.cornerRadius = view.frame.height / 2
        
    }
    
    class func secondsToHoursMinutesSeconds (seconds : Double) -> (Int, Int, Int) {
        let (hr,  minf) = modf (seconds / 3600)
        let (min, secf) = modf (60 * minf)
        return (Int(hr), Int(min), 60 * Int(secf))
    }
    

}
