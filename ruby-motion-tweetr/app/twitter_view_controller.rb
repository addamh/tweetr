class TwitterViewController < UITableViewController

  attr_accessor :statuses

  StatusCellIdentifier = 'StatusCell'

  def viewDidLoad
    setTitle('#RubyMotion')
    @statuses = []
  end

  def viewWillAppear(animated)
    loadTimeline
  end

  def tableView(tv, numberOfRowsInSection: section)
    statuses.size
  end

  def tableView(tv, cellForRowAtIndexPath: indexPath)
    cell = tv.dequeueReusableCellWithIdentifier(StatusCellIdentifier) || 
          StatusCell.alloc.initWithReuseIdentifier(StatusCellIdentifier)

    cell.tweet = statuses[indexPath.row]
    cell
  end

  def tableView(tv, didSelectRowAtIndexPath:indexPath)
    tv.deselectRowAtIndexPath(indexPath, animated:true)
  end

  def tableView(tv, heightForRowAtIndexPath: indexPath)
    StatusCell.heightForCellWithTweet(statuses[indexPath.row])
  end
 
  def loadTimeline

    BW::HTTP.get("https://search.twitter.com/search.json?q=%23rubymotion") do |response|
      if response
        error = Pointer.new(:id)
        parsedResponse = BW::JSON.parse response.body.to_str
        
        timelineData = parsedResponse["results"] 

        unless timelineData.empty?
          @since_id = timelineData[0]["id_str"]
          @statuses = timelineData.map { |data| Tweet.new(data) } + @statuses
        end
        
        view.performSelectorOnMainThread('reloadData', withObject: nil, waitUntilDone: false)
      else
        # TODO Implement error handling
      end
    end
  end

end