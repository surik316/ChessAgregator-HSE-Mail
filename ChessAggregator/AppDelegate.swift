import UIKit
import Firebase
import FirebaseDatabase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    //private let auth = Auth.auth()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window)
        self.window = window
        //self.appCoordinator?.auth()
        Auth.auth().addStateDidChangeListener{[weak self] (auth,user) in
            if Auth.auth().currentUser != nil{
                self?.appCoordinator?.startApp()
            }
            else{
                self?.appCoordinator?.auth()
                //self?.showModalAuth()
            }
        }
        return true
    }
    func showModalAuth(){
//        let storyboard = UIStoryboard
//        let newVC = storyboard.instantiateViewController(withIdentifier: "AuthViewControllerc") as! AuthViewController
//        self.window?.rootViewController?.present(newVC, animated: true, completion: nil)
    }


}

