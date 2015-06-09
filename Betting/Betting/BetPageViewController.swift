//
//  BetPageViewController.swift
//  Betting
//
//  Created by Myantel on 6/8/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit
import Parse

var betMatchId = ""
var betLocal = ""
var betVisitor = ""
var betMatchHomeTeamId = ""
var betMatchAwayTeamId = ""
var teamName = ["", "Arsenal", "Chelsea"]

class BetPageViewController: UIViewController, PayPalPaymentDelegate {

    var teamChoose = 0
    var sData = SoccerData()
    
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
                
                if self.teamChoose == 1 {
                    self.sData.uploadBet(PFUser.currentUser()!.objectId!, matchId: betMatchId, teamId: betMatchHomeTeamId, teamId2: "0", betAmount: self.betAmount.text, payPalId: response["id"]as! String)
                } else {
                    self.sData.uploadBet(PFUser.currentUser()!.objectId!, matchId: betMatchId, teamId: "0", teamId2: betMatchAwayTeamId, betAmount: self.betAmount.text, payPalId: response["id"]as! String)
                }
                
            }
        })
    }

}
