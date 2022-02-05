import UIKit
import CoreData
import MapKit
import GoogleSignIn


class ProfileViewController: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func SignIn(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance.signOut()
    
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "signInVC") as? SignInVC else {
            return
        }
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.changeRootVC(vc, animated: true)
    }
}
