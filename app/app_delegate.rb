class AppDelegate
  UUID = 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA' # FIXME

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |w|
      w.rootViewController = UINavigationController.alloc.initWithRootViewController(MembersViewController.new)
      w.makeKeyAndVisible
    end

    @manager = CLLocationManager.new
    @manager.delegate = self
    @manager.requestAlwaysAuthorization # for ios8

    uuid = NSUUID.alloc.initWithUUIDString(UUID)
    @region = CLBeaconRegion.alloc.initWithProximityUUID(uuid, identifier: "club.yurudev.room")
    @region.notifyOnEntry = true
    @region.notifyOnExit  = true
    @region.notifyEntryStateOnDisplay = false

    @manager.startMonitoringForRegion(@region)

    true
  end

  def locationManager(manager, didEnterRegion: region)
    puts "didEnterRegion"
    return unless username

    data = { uuid: UUID }
    BubbleWrap::HTTP.post("https://kina.herokuapp.com/api/users/#{username}/stays.json", {payload: data}) do |response|
      puts "send didEnterRegion to server"
      p response.ok?
    end
  end

  def locationManager(manager, didExitRegion: region)
    puts "didExitRegion"
    return unless username

    BubbleWrap::HTTP.delete("https://kina.herokuapp.com/api/users/#{username}/stays.json") do |response|
      puts "send didExitRegion to server"
      p response.ok?
    end
  end

  def username
    name = NSUserDefaults.standardUserDefaults["username"]
    name && name.size > 0 ? name : nil
  end
end
