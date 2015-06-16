import UIKit

var boxView = UIView()

public class LoadingOverlay {

    var activityView: DTIActivityIndicatorView = DTIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView) {
        var xPos = view.bounds.size.width / 2
        var yPos = view.bounds.size.height / 2
        boxView = UIView(frame: CGRect(x: xPos - 70, y: yPos - 50, width: 140, height: 50))
        boxView.backgroundColor = UIColor.blackColor()
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        activityView.indicatorColor = UIColor.whiteColor()
        activityView.indicatorStyle = DTIIndicatorStyle.convInv(.pulse)
        activityView.startActivity()
        
        var textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.grayColor()
        textLabel.text = "Loading"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)

    }
    
    public func hideOverlayView() {
        dispatch_async(dispatch_get_main_queue(), {
            boxView.removeFromSuperview()
            self.activityView.stopActivity()
        })

    }
}