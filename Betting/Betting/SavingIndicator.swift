//var boxView = UIView()
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    view.backgroundColor = UIColor.blackColor()
//    addSavingPhotoView()
//    
//    //Custom button to test this app
//    var button = UIButton(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
//    button.backgroundColor = UIColor.redColor()
//    button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
//    
//    view.addSubview(button)
//}
//
//func addSavingPhotoView() {
//    // You only need to adjust this frame to move it anywhere you want
//    boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
//    boxView.backgroundColor = UIColor.whiteColor()
//    boxView.alpha = 0.8
//    boxView.layer.cornerRadius = 10
//    
//    //Here the spinnier is initialized
//    var activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
//    activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//    activityView.startAnimating()
//    
//    var textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
//    textLabel.textColor = UIColor.grayColor()
//    textLabel.text = "Saving Photo"
//    
//    boxView.addSubview(activityView)
//    boxView.addSubview(textLabel)
//    
//    view.addSubview(boxView)
//}
//
//func buttonAction(sender:UIButton!) {
//    //When button is pressed it removes the boxView from screen
//    boxView.removeFromSuperview()
//}