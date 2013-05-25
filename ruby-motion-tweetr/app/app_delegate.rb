class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = Motion::Xray::XrayWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(TwitterViewController.alloc.initWithStyle(UITableViewStylePlain))
    @window.makeKeyAndVisible
    true
  end
end
