use Rack::Static, urls: ['/images'],
                  root: 'public'

class Pet
  def initialize(name)
    @name = name
    @asleep = false #Doesn't want to sleep
    @stuffInBelly     = 8 # satiety
    @stuffInIntestine = 0 # toilet
    @goodmood = true # Mood, depends on sleep, satiety, toilet
    @health = 10 # Health, depends on sleep, satiety, toilet
  end

  @@born_img = "<h1><img src='/images/born.jpg' width='150' height='200'></h1>"
  @@feed_img = "<h1><img src='/images/feed.png' width='150' height='200'></h1>"
  @@gift_img = "<h1><img src='/images/gift.png' width='150' height='200'></h1>"
  @@treat_img = "<h1><img src='/images/treat.jpg' width='150' height='200'></h1>"
  @@toilet_img = "<h1><img src='/images/toilet.jpg' width='150' height='200'></h1>"
  @@sleep_img = "<h1><img src='/images/sleep.png' width='150' height='200'></h1>"
  @@play_img = "<h1><img src='/images/play.png' height='150'></h1>"
  @@rock_img = "<h1><img src='/images/rock.png' width='150 height='200'></h1>"
  @@dead_img = "<h1><img src='/images/dead.jpg' width='150' height='200'></h1>"

  def call(env)
    @@condishion =
    "<div style='float:left; width:220px; height:300px; border: 1px solid; padding: 5px;'><br>MY CONDITIONS
      <p>&#127831; satiety: <b>#{@stuffInBelly}</b> (max 8)</p>
      <p>&#128169; intestine: <b>#{@stuffInIntestine}</b> (max 6)</p>
      <p>&#10010; health: <b>#{@health}</b> (max 10)</p>
      <p>&#128522; has good mood: <b>#{@goodmood}</b></p>
      <p>&#128164; wants to sleep: <b>#{@asleep}</b></p></div>"
    @@choose =
      "<div style='float:left; width:220px; height:300px; border: 1px solid; padding: 5px; px '><br>CHOOSE AN OPTION
      <p><b><a href = \"/feed\">Feed me</a></p>
      <p><a href = \"/toilet\">Put me on a piss-pot</a></p>
      <p><a href = \"/treat\">Give me a pill</a></p>
      <p><a href = \"/play\">Play with me</a></p>
      <p><a href = \"/sleep\">Put me to bed</a></p>
      <p><a href = \"/rock\">Sing for me lullaby</a></p>
      <p><a href = \"/gift\">Bye me a gift</a></p></div>"



    req = Rack::Request.new(env)
    case req.path_info
    when '/'
      [200, { 'Content-Type' => 'text/html' },
       ["<h1>Hello, mate! I'm your new friend. <br>My name's #{@name}</h1> #{@@born_img} <br><h2>#{@info}</h2><br> #{@@condishion} #{@@choose}"]]

    when /feed/
      feed
      [200, { 'Content-Type' => 'text/html' },
       ["#{@feedfollow} <br> #{@@feed_img} <h2 style= 'color: red;'>#{@died}</h2> <h3>#{@info}<br> #{@follow}</h3><br> #{@@condishion} #{@@choose} "]]

    when /gift/
      gift
      [200, { 'Content-Type' => 'text/html' },
        ["#{@giftfollow} <br> #{@@gift_img} <h2 style= 'color: red;'>#{@died}</h2> <h3>#{@info}<br> #{@follow}</h3><br> #{@@condishion} #{@@choose} "]]

    when /treat/
      treat
      [200, { 'Content-Type' => 'text/html' },
       ["#{@treatfollow} <br> #{@@treat_img} <h2 style= 'color: red;'>#{@died}</h2> <h3>#{@info}<br> #{@follow}</h3><br> #{@@condishion} #{@@choose} "]]

    when /toilet/
      toilet
      [200, { 'Content-Type' => 'text/html' },
       ["#{@toiletfollow} <br> #{@@toilet_img} <h2 style= 'color: red;'>#{@died}</h2> <h3>#{@info}<br> #{@follow}</h3><br> #{@@condishion} #{@@choose} "]]

    when /sleep/
      sleep
      [200, { 'Content-Type' => 'text/html' },
       ["#{@sleepfollow} <br> #{@@sleep_img} <h2 style= 'color: red;'>#{@died}</h2> <h3>#{@info}<br> #{@follow}</h3><br> #{@@condishion} #{@@choose} "]]

    when /play/
      play
      [200, { 'Content-Type' => 'text/html' },
       ["#{@playfollow} <br> #{@@play_img} <h2 style= 'color: red;'>#{@died}</h2> <h3>#{@info}<br> #{@follow}</h3><br> #{@@condishion} #{@@choose} "]]

    when /rock/
      rock
      [200, { 'Content-Type' => 'text/html' },
       ["#{@rockfollow} <br> #{@@rock_img} <h2 style= 'color: red;'>#{@died}</h2> <h3>#{@info}<br> #{@follow}</h3><br> #{@@condishion} #{@@choose} "]]

    else
      [404, { 'Content-Type' => 'text/html' },
       ["<h1>#{@name} died...</h1><br><h2 style= 'color: red;'>#{@died}</h2><br> <a href='/'>Start again</a>#{@@dead_img} #{@@condishion}"]]
     end
  end

  def feed
    @stuffInBelly = 8
    @feedfollow = '"Hmmmmm... tasty!"'.upcase
    puts @feedfollow
    # puts 'You gave to ' + @name + ' some food.'
    passageOfTime
  end

  def gift
    @giftfollow = '"Coool! Thanks"'.upcase
    puts @giftfollow
    # puts 'You gave to ' + @name + ' some \"Roshen\".'
    @stuffInBelly += 1
    @health -= 1
    @goodmood = false
    passageOfTime
end

  def treat
    @treatfollow = '"Are you going to poison me?!"'.upcase
    puts @treatfollow
    # puts 'You gave ' + @name + 'a pill.'
    @health = 10
    passageOfTime
  end

  def toilet
    @stuffInIntestine = 0
    @toiletfollow = 'Pooock!!! - "It`s not me!"'.upcase
    puts @toiletfollow
    # puts 'You seat ' + @name + '(а) on a piss-pot.'
    passageOfTime
  end

  def sleep
    @sleepfollow = '"hr...hrrr...hrrrrr..."'.upcase
    puts @sleepfollow
    # puts  @name + ' sleeping.'
    @asleep = true # wants sleep
    1.times do
      if @asleep # wants sleep
        passageOfTime
        end
        if @asleep
        @info = @name + ' sleeping and chawing.'
        puts @info
      end
    end
    if @asleep
      @asleep = false # doesn't want sleep
      @info = @name + ' wakes up and yawns.'
      puts @info
    end
  end

  def play
    @playfollow = '"juuuhhhuuu!!!"'.upcase
    puts @playfollow
    # puts 'You and ' + @name + ' tumbling on the floor.'
    @goodmood = true
    passageOfTime
  end

  def rock
    @rockfollow = '"You are nice singer, mate!"'.upcase
    '<br>' + @name + ' drowses...'
    puts @rockfollow
    # puts 'You sing to ' + @name + 'lullaby.'
    @asleep = true
    # puts @name + ' drowses.'
    passageOfTime
    if @asleep
      @asleep = false
      @rockfollow = '"Big stage is crying for you!!!"'.upcase
      puts @rockfollow
    end
  end

  private

  def hungry?
    @stuffInBelly <= 2
  end

  def poopy?
    @stuffInIntestine > 3
  end

  def passageOfTime
    if @stuffInBelly > 0
      #  Moove food from stomach to intestine
      @stuffInBelly  = @stuffInBelly - 1
      @stuffInIntestine = @stuffInIntestine + 1


    else # starving
      if @asleep
        @asleep = false
        @follow = 'He wakes up suddenly!'
        puts @follow

        # puts 'He wakes up suddenly!'
      end
      if @goodmood
        @goodmood = false
        @info = 'He whines!'
        puts @info

      #    puts 'He whines!'
    end
      @died = 'Sorry!' + @name + ' died because of starvation!'
      puts @died
      # puts @name + ' died because of starvation!'
      #exit  #Finish program
    end

    #-------------------------
    if @stuffInBelly <= 2
      @health  -= 2 # health down
    end

    if @goodmood == false
      @health  -= 1
    end

    if @health > 3
    @goodmood = true
    else  #  bad health
    @info = 'He has a fever!'
    puts @info
    end

    #-------------------------
    if @health <= 0
      @died = 'Sorry!' + @name + ' died because of fever!'
      puts @died
      # puts @name + ' died because of fever!'
    end
    #-------------------------

    if @stuffInIntestine >= 6
      @stuffInIntestine = 0
      @goodmood = false
      @info = 'He craped his pants...'
      puts @info
      # puts 'Оh! ' + @name + ' craps his pants...'
    end

    if hungry?
      if @asleep
        @asleep = false
        @follow = 'He wakes up suddenly!'
        puts @follow
      # puts 'He wakes up suddenly!'
    end
      if @goodmood
        @goodmood = false
        @info = 'He whines!'
        puts @info
      # puts 'He whines!'
    end
      @follow = 'He is starving...'
      puts @follow
      # puts @name +  ' s starving...'
    end

    if poopy?
      if @asleep
        @asleep = false
        @follow = 'He wakes up!'
        puts @follow
        # puts 'He wakes up!'
      end
      @follow = 'He needs a pot...'
      puts @follow
      # puts @name + ' needs a pot...'
    end
  end
end

run Pet.new 'BOB'
