//
//  BetPageViewController.swift
//  Betting
//
//  Created by Myantel on 6/8/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit
import Parse

let userObjectId = PFUser.currentUser()!.objectId!
var betMatchId = ""
var betLocal = ""
var betVisitor = ""
var betMatchHomeTeamId = ""
var betMatchAwayTeamId = ""
var teamName = ["", "Arsenal", "Chelsea"]
//Bet

class BetPageViewController: UIViewController, PayPalPaymentDelegate {
    
    var sMatch: SoccerMatch = getData.matchArray.objectAtIndex(activeRow) as! SoccerMatch
    
    var textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 100, height: 50))

    var activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    var paypalID = ""
    var teamChoose = 0
    var sData = SoccerData()
    var checkMark = UIImageView()
    //Paypal
    var environment:String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    var payPalConfig = PayPalConfiguration() // default
    
    
    @IBOutlet weak var team1Rate: UILabel!
    @IBOutlet weak var team1Rank: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1: UIButton!
    @IBAction func team1button(sender: AnyObject) {
        teamChoose = 1
        team1.backgroundColor = nil
        team1.alpha = 1.0
        team2.backgroundColor = UIColor.blackColor()
        team2.alpha = 0.4
        println(teamName[1])
    }
    
    @IBOutlet weak var team2Rate: UILabel!
    @IBOutlet weak var team2Rank: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team2: UIButton!
    @IBAction func team2button(sender: AnyObject) {
        teamChoose = 2
        team1.backgroundColor = UIColor.blackColor()
        team1.alpha = 0.4
        team2.backgroundColor = nil
        team2.alpha = 1.0
        println(teamName[2])

    }
    
    @IBOutlet weak var betAmount: UITextField!
    
    @IBAction func submitBet(sender: AnyObject) {
        var teamBet = PayPalItem(name: teamName[teamChoose], withQuantity: 1, withPrice: NSDecimalNumber(string: betAmount.text), withCurrency: "USD", withSku: "Bet")
        
        let items = [teamBet]
        let subtotal = PayPalItem.totalPriceForItems(items)
        
        let payment = PayPalPayment(amount: subtotal, currencyCode: "USD", shortDescription: "Betting Soccer", intent: .Sale)
        
        payment.items = items
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            println("Payment not processable: \(payment)")
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "overlayEnder", name: "paymentDone", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveToParse", name: "parseLocal", object: nil)


        //Paypal
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Betting Yangon"
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0] as! String
        payPalConfig.payPalShippingAddressOption = .PayPal;
        //println("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
        
        //Getting data
        let fixture: SoccerMatch = getData.matchArray.objectAtIndex(activeRow) as! SoccerMatch
        team1Name.text = fixture.getMatchHomeTeamName
        team2Name.text = fixture.getMatchAwayTeamName
        //Team Rate
        let homeTeamTotal = (fixture.getMatchLocalTeamTotal as NSString).doubleValue
        let awayTeamTotal = (fixture.getMatchVisitorTeamTotal as NSString).doubleValue
        let total = (fixture.getMatchPoolTotal as NSString).doubleValue
        
        //Getting Rate
        if total > 0 {
            let homeRate = homeTeamTotal/total
            let awayRate = awayTeamTotal/total
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)
            let roundedHome = NSInteger((round(homeRate * multiplier) / multiplier) * 100)
            let roundedAway = NSInteger((round(awayRate * multiplier) / multiplier) * 100)
            team1Rate.text = String(stringInterpolationSegment: roundedHome) + "%"
            team2Rate.text = String(stringInterpolationSegment: roundedAway) + "%"
        } else {
            team1Rate.text = "0%"
            team2Rate.text = "0%"
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnectWithEnvironment(environment)
    }
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        println("PayPal Payment Cancelled")
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        println("PayPal Payment Success !")
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            // send completed confirmaion to your server
            println("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            if let response: AnyObject = completedPayment.confirmation["response"] {
                self.paypalID = response["id"]as! String
                self.callUpload()
            }
        })
    }

    func overlayCaller() {
        self.view.userInteractionEnabled = false
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.whiteColor()
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        //CheckMark image view
        checkMark.frame = CGRect(x: +10, y: +10, width:30, height:30)
        checkMark.image = UIImage(named: "checkmark.png")
        checkMark.hidden = true
        //Here the spinnier is initialized
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        textLabel.textColor = UIColor.grayColor()
        textLabel.text = "Processing"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        boxView.addSubview(checkMark)
        
        view.addSubview(boxView)
    }
    func overlayEnder() {
        dispatch_async(dispatch_get_main_queue(), {
            self.view.userInteractionEnabled = true
            self.textLabel.text = "Complete"
            self.checkMark.hidden = false
            self.activityView.stopAnimating()
            let delayTime = dispatch_time(DISPATCH_TIME_NOW,
                Int64(3 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                boxView.removeFromSuperview()
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
    }
    func callUpload() {
        
        if self.teamChoose == 1 {
            self.overlayCaller()
            self.sData.uploadBet(userObjectId, matchId: betMatchId, teamId: betMatchHomeTeamId, teamId2: "0", betAmount: self.betAmount.text, payPalId: paypalID)

        } else {
            self.overlayCaller()
            self.sData.uploadBet(userObjectId, matchId: betMatchId, teamId: "0", teamId2: betMatchAwayTeamId, betAmount: self.betAmount.text, payPalId: paypalID)

        }
    }
    
    func saveToParse() {
        let nameBet = PFObject(className:"betList")
        nameBet["Match"] = sMatch
        nameBet["userObjectId"] = userObjectId
        nameBet["matchId"] = betMatchId
        nameBet["teamId"] = betMatchHomeTeamId
        nameBet["teamId2"] = "0"
        nameBet["betAmount"] = self.betAmount.text
        nameBet["paypalId"] = paypalID
        nameBet.pinInBackground()
    }
}
