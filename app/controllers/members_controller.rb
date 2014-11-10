class MembersViewController < UITableViewController
  UUID = 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA' # FIXME
  def viewDidLoad
    super
    self.navigationItem.title = "Members"

    reload_members
  end

  def tableView(tableView, numberOfRowsInSection:section)
    return 0 if @users_data.nil?

    @users_data['users'].size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('cell') ||
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:'cell')

    # cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator
    mark   = @users_data['users'][indexPath.row]['active'] ? '✔' : ' '
    name   = @users_data['users'][indexPath.row]['name']
    cell.textLabel.text = "#{mark} #{name}"
    cell.textLabel.font = UIFont.boldSystemFontOfSize(14)

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
  end

private

  def reload_members
    BW::HTTP.get("https://kina.herokuapp.com/api/spots/#{UUID}/users.json") do |response|
      if response.ok?
        @users_data = BW::JSON.parse(response.body.to_s)
        view.reloadData
      else
        puts "error"
        App.alert(response.error_message)
      end
    end
  end
end
