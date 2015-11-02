//
//  ViewController.swift
//  childrenCalculator
//
//  Created by Yishi Xie on 10/17/15.
//  Copyright © 2015 Yishi Xie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var num1stValue = 0
    var num2stValue = 0
    var numTotalValue = 0
    var mode = 0
    var valueString:String! = ""
    var lastButtonWasMode:Bool = false
    
    
    let mySpeechSyth = AVSpeechSynthesizer()
    var myRate: Float = 0.35
    var myPitch: Float = 1.4
    var myVolume: Float = 0.7
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var visualEmoji: UILabel!
    
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    
    //  MARK: Speak String Function
    func speakThisString (myString: String){
        let myUtterance = AVSpeechUtterance(string: myString)
        myUtterance.voice = AVSpeechSynthesisVoice(language: currentLang.0)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        
        mySpeechSyth.speakUtterance(myUtterance)
    }
    
    
    
    // MARK: Button Press
    
    @IBAction func numberButtonPressed(sender: UIButton) {
        // String rep for number
        let numberString = sender.titleLabel!.text
        let numberInt = Int(numberString!)
        
        speakThisString(numberString!)
        
        // when open avoid typing multiple 0
        if(numberInt == 0 && numTotalValue == 0){
            return
        }
        if(lastButtonWasMode)
        {
            lastButtonWasMode = false
            valueString = ""
            //when last button was mode but then type new number directly
            if(mode==0){
                numTotalValue = 0
            }
        }
        
        valueString = valueString.stringByAppendingString(numberString!)
        
        //formatting the number with commmas
        let formatter: NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        
        myLabel.text = formatter.stringFromNumber(n)
        
        if (numTotalValue == 0)
        {
            numTotalValue = Int(valueString)!
        }
    }
    
    
    
    @IBAction func tappedPlus(sender: UIButton) {
        self.setMmode(1)
        speakThisString("plus")
    }
    
    
    @IBAction func tappedMinus(sender: UIButton) {
        self.setMmode(-1)
        speakThisString("minus")
    }
    
    
    @IBAction func tappedMultiply(sender: UIButton) {
        self.setMmode(2)
        speakThisString("multiply")
    }
    
    @IBAction func tappedDivide(sender: UIButton) {
        self.setMmode(3)
        speakThisString("divide")
    }
    
    
    @IBAction func equalsPressed(sender: UIButton) {
        if (mode == 0)
        {
            return
        }
        //store the current label number
        let iNum: Int = Int(valueString)!
//        speakThisString(valueString)
        
        if(mode == 1){
            speakThisString("equals")
            numTotalValue += iNum
        }
        if(mode == -1){
            speakThisString("equals")
            numTotalValue -= iNum
        }
        if(mode == 2){
            speakThisString("equals")
            numTotalValue *= iNum
        }
        if(mode == 3){
            speakThisString("equals")
            numTotalValue /= iNum
        }
        valueString = "\(numTotalValue)"
        
        let formatter: NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        myLabel.text = formatter.stringFromNumber(n)
        speakThisString(valueString)
        
        //set things back to the original state
        mode = 0
        lastButtonWasMode = true
        
    }
    

    @IBAction func repeatNumber(sender: UIButton) {
         speakThisString(valueString)
    }
    
    //MARK: Clear
    
    @IBAction func tappedClear(sender: UIButton) {
        speakThisString("clear zero")
        numTotalValue = 0
        mode = 0
        valueString = ""
        myLabel.text = "0"
        lastButtonWasMode = false
    
        //get the rgb info for night mode
        print(b3.backgroundColor)
        print(myLabel.backgroundColor)
        print(bdivide.backgroundColor)
        print(selectWindow.backgroundColor)
    }
    
    
    //MARK: Set Mode
    func setMmode(m:Int){
        if(numTotalValue == 0)
        {
            return
        }
        mode = m
        lastButtonWasMode = true
        numTotalValue = Int(valueString)!
    }
    
    //MARK - UIPickerView Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langCodeAll38.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let myString = "\(langCodeAll38[row].4) \(langCodeAll38[row].3)"
        
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLang = langCodeAll38[row]
        speakThisString(currentLang.3)
    }
    
    
    
    //MARK: current lang array has known typos, to fix in future.
    var langCodeAll38 = [
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
        ("cs-CZ", "Czech", "Czech Republic","český","🇨🇿"),
        ("da-DK", "Danish","Denmark","Dansk","🇩🇰"),
        ("de-DE",       "German", "Germany", "Deutsche","🇩🇪"),
        ("el-GR",      "Modern Greek",        "Greece","ελληνική","🇬🇷"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),
        ("fi-FI",       "Finnish",     "Finland","Suomi","🇫🇮"),
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("hu-HU",       "Hungarian",    "Hungary", "Magyar","🇭🇺"),
        ("id-ID",       "Indonesian",    "Indonesia","Bahasa Indonesia","🇮🇩"),
        ("it-IT",       "Italian",     "Italy", "Italiano","🇮🇹"),
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),
        ("no-NO",       "Norwegian",    "Norway", "Norsk","🇳🇴"),
        ("pl-PL",       "Polish",      "Poland", "Polski","🇵🇱"),
        ("pt-BR",       "Portuguese",      "Brazil","Portuguese","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Portuguese","🇵🇹"),
        ("ro-RO",       "Romanian",        "Romania","Română","🇷🇴"),
        ("ru-RU",       "Russian",     "Russian Federation","русский","🇷🇺"),
        ("sk-SK",       "Slovak",      "Slovakia", "Slovenčina","🇸🇰"),
        ("sv-SE",       "Swedish",     "Sweden","Svenska","🇸🇪"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        ("tr-TR",       "Turkish",     "Turkey","Türkçe","🇹🇷"),
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
    ]
    
    
    //MARK: Two visual modes
    //connect buttons
    @IBOutlet weak var b0: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var bplus: UIButton!
    @IBOutlet weak var bminus: UIButton!
    @IBOutlet weak var bmultiply: UIButton!
    @IBOutlet weak var bdivide: UIButton!
    @IBOutlet weak var bequal: UIButton!
    @IBOutlet weak var bclear: UIButton!
    @IBOutlet weak var selectWindow: UIPickerView!
    @IBOutlet weak var repeatNumber: UIButton!
    
    var visualSwitch:Bool = true
    
    
    @IBAction func visualMode(sender: UISwitch) {
        
        //if the switch is on change to night mode
        visualSwitch = !visualSwitch
        if(visualSwitch){
            //Smooth animated transition between  view modes
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.visualEmoji.text = "     🌞"
                
            self.view.backgroundColor = UIColor(red: 0.482697, green: 0.835938, blue: 0.727261, alpha: 1)
            
            self.b0.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b0.layer.cornerRadius = 30
            
            self.b1.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b1.layer.cornerRadius = 30
            
            self.b2.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b2.layer.cornerRadius = 30
            
            self.b3.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b3.layer.cornerRadius = 30
            
            self.b4.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b4.layer.cornerRadius = 30
            
            self.b5.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b5.layer.cornerRadius = 30
            
            self.b6.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b6.layer.cornerRadius = 30
            
            self.b7.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b7.layer.cornerRadius = 30
            
            self.b8.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b8.layer.cornerRadius = 30
            
            
            self.b9.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
            self.b9.layer.cornerRadius = 30
            
            
            self.bclear.layer.cornerRadius = 30
            self.bclear.layer.borderColor = UIColor.whiteColor().CGColor
            self.bclear.layer.borderWidth = 1
            
            
            self.repeatNumber.layer.cornerRadius = 30
            self.repeatNumber.layer.borderColor = UIColor.whiteColor().CGColor
            self.repeatNumber.layer.borderWidth = 1
            
            self.bmultiply.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
            self.bmultiply.layer.cornerRadius = 20
            
            self.bminus.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
            self.bminus.layer.cornerRadius = 20
            
            self.bplus.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
            self.bplus.layer.cornerRadius = 20
            
            self.bdivide.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
            self.bdivide.layer.cornerRadius = 20
            
            self.bequal.backgroundColor = UIColor(red: 0.864716, green: 0.746861, blue: 0.904711, alpha: 1)
            self.bequal.layer.cornerRadius = 20
            
            self.myLabel.textColor = UIColor.blackColor()
            self.myLabel.backgroundColor = UIColor(red: 0.867936, green: 1, blue: 0.947783, alpha: 1)
            self.selectWindow.backgroundColor = UIColor(red: 0.867936, green: 1, blue: 0.947783, alpha: 0.8)
              }, completion: nil)

            
            
        }else{
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            self.visualEmoji.text = "🌚"
            
            self.view.backgroundColor = UIColor(red: 0.366967, green: 0.32422, blue: 0.403251, alpha: 1)
            self.b0.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b0.layer.cornerRadius = 30
            
            self.b1.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b1.layer.cornerRadius = 30
            
            self.b2.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b2.layer.cornerRadius = 30
            
            self.b3.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b3.layer.cornerRadius = 30
            
            self.b4.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b4.layer.cornerRadius = 30
            
            self.b5.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b5.layer.cornerRadius = 30
            
            self.b6.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b6.layer.cornerRadius = 30
            
            self.b7.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b7.layer.cornerRadius = 30
            
            self.b8.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b8.layer.cornerRadius = 30
            
            self.b9.backgroundColor = UIColor(red: 0.933298, green: 0.758536, blue: 0.010837, alpha: 0.5)
            self.b9.layer.cornerRadius = 30
            
            
            self.bclear.layer.cornerRadius = 30
            self.bclear.layer.borderColor = UIColor.blackColor().CGColor
            self.bclear.layer.borderWidth = 1
            
            
            self.repeatNumber.layer.cornerRadius = 30
            self.repeatNumber.layer.borderColor = UIColor.blackColor().CGColor
            self.repeatNumber.layer.borderWidth = 1
            
            self.bmultiply.backgroundColor = UIColor(red: 0.341246, green: 0.564789, blue: 0.378813, alpha: 1)
            self.bminus.backgroundColor = UIColor(red: 0.341246, green: 0.564789, blue: 0.378813, alpha: 1)
            self.bplus.backgroundColor = UIColor(red: 0.341246, green: 0.564789, blue: 0.378813, alpha: 1)
            self.bdivide.backgroundColor = UIColor(red: 0.341246, green: 0.564789, blue: 0.378813, alpha: 1)
            self.bequal.backgroundColor = UIColor(red: 0.611368, green: 0.365112, blue: 0.317234, alpha: 1)
            
            self.myLabel.textColor = UIColor.whiteColor()
            self.myLabel.backgroundColor = UIColor(red: 0.0403182, green: 0.207912, blue: 0.298907, alpha: 1)
            
            self.selectWindow.backgroundColor = UIColor(red: 0.0403182, green: 0.207912, blue: 0.298907, alpha: 0.8)
                  }, completion: nil)
            
        }
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "0"
        speakThisString("number is fun")
        
        //start look
        visualEmoji.text = "     🌞"
        self.view.backgroundColor = UIColor(red: 0.482697, green: 0.835938, blue: 0.727261, alpha: 1)
        
        b0.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b0.layer.cornerRadius = 30
        
        b1.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b1.layer.cornerRadius = 30
        
        b2.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b2.layer.cornerRadius = 30
        
        b3.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b3.layer.cornerRadius = 30
        
        b4.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b4.layer.cornerRadius = 30
        
        b5.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b5.layer.cornerRadius = 30
        
        b6.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b6.layer.cornerRadius = 30
        
        b7.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b7.layer.cornerRadius = 30
        
        b8.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b8.layer.cornerRadius = 30
        
        
        b9.backgroundColor = UIColor(red: 0.971788, green: 0.840634, blue: 0.407131, alpha: 1)
        self.b9.layer.cornerRadius = 30
        
        
        self.bclear.layer.cornerRadius = 30
        self.bclear.layer.borderColor = UIColor.whiteColor().CGColor
        self.bclear.layer.borderWidth = 1
        
        
        self.repeatNumber.layer.cornerRadius = 30
        self.repeatNumber.layer.borderColor = UIColor.whiteColor().CGColor
        self.repeatNumber.layer.borderWidth = 1
        
        bmultiply.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
        self.bmultiply.layer.cornerRadius = 20
        
        bminus.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
        self.bminus.layer.cornerRadius = 20
        
        bplus.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
        self.bplus.layer.cornerRadius = 20
        
        bdivide.backgroundColor = UIColor(red: 0.720793, green: 0.879669, blue: 1, alpha: 1)
        self.bdivide.layer.cornerRadius = 20
        
        bequal.backgroundColor = UIColor(red: 0.864716, green: 0.746861, blue: 0.904711, alpha: 1)
        self.bequal.layer.cornerRadius = 20
        
        myLabel.textColor = UIColor.blackColor()
        myLabel.backgroundColor = UIColor(red: 0.867936, green: 1, blue: 0.947783, alpha: 0.7)
        selectWindow.backgroundColor = UIColor(red: 0.867936, green: 1, blue: 0.947783, alpha: 1)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

