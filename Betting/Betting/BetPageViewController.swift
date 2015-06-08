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

class BetPageViewController: UIViewController, PayPalPaymentDelegate {

    var sData = SoccerData()
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
    
    var teamChoose = 0
    var teamName = ["", "Arsenal", "Chelsea"]
    @IBAction func team1button(sender: AnyObject) {
        betMatchHomeTeamId == betLocal
        betMatchAwayTeamId = "0"
        teamChoose = 1
        println(betMatchHomeTeamId)
    }
    @IBAction func team2button(sender: AnyObject) {
        betMatchAwayTeamId == betVisitor
        betMatchHomeTeamId = "0"
        teamChoose = 2
        println(betMatchAwayTeamId)
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
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Betting Yangon"
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0] as! String
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        println("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
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
                println(response["id"])
                self.sData.uploadBet(PFUser.currentUser()!.objectId!, matchId: betMatchId, teamId: betMatchHomeTeamId, teamId2: betMatchAwayTeamId, betAmount: self.betAmount.text, payPalId: response["id"]as! String)
            }
        })
    }

}
