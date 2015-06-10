import UIKit

public class LoadingOverlay {
    
    var overlayView = UIView()
    var myActivityIndicatorView: DTIActivityIndicatorView = DTIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView) {
        
        
        
        myActivityIndicatorView.frame = CGRectMake(0, 0, 40, 40)
        myActivityIndicatorView.center = view.center
        myActivityIndicatorView.indicatorColor = UIColor.blackColor()
        myActivityIndicatorView.indicatorStyle = DTIIndicatorStyle.convInv(.chasingDots)
        
        view.addSubview(myActivityIndicatorView)
        
        myActivityIndicatorView.startActivity()
    }
    
    public func hideOverlayView() {
        myActivityIndicatorView.removeFromSuperview()
        myActivityIndicatorView.stopActivity()

    }
}