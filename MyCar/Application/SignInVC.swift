import Foundation
import UIKit
import GoogleSignIn

class SignInVC: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: googleSignInToket)
    
    @IBAction func signInUIButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
           
        guard error == nil else { return }
            
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
        let vc = storyboard.instantiateViewController(withIdentifier: "mainTabBarVC")
                
        guard  let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            print ("Cant cast scenedelegate ")
            return
        }
            
        sceneDelegate.changeRootVC(vc, animated: true)
        }
    }
}
