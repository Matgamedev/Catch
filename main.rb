def var args
  @px           ||= 1280/2
  @life         ||= 3
  @score        ||= 0
  @spawnx       ||= 0
  @spawndir     ||= 0
  @spawntime    ||= 100
  @goldy        ||= 575
  @drop         ||= 0 
  @goldx        ||=0
  @gold           = [@goldx, @goldy,25,25]
  @player         = [@px,0,50,100,255,255,255]
  @start        ||=0
  @gameover     ||=0
  @name         ||='mat'
  @highscore1   ||=0
  @highscore2   ||=0
  @highscore3   ||=0
end
  
def start args
if @start == 0
  
  args.outputs.labels << [500,400,"Name "]
  args.outputs.labels << [575,400,@name]
end

  if args.inputs.keyboard.enter
    @start = 1
    @score = 0
    @life = 3
  end
end
 
def gameover args
  if @life <= 0 && @start == 1
    @start = 0
      args.outputs.labels << [0,700,"Score: "]
      args.outputs.labels << [75,700,@score]
   end
   if @life <= 0 && @start == 0
      args.outputs.labels << [575,500,"high Score: "]
      args.outputs.labels << [700,475,@highscore1]
      args.outputs.labels << [700,455,@highscore2]
      args.outputs.labels << [700,435,@highscore3]
   end
end
  
def score args


  if @score >= @highscore1
    @highscore1 = @score

  elsif @score >= @highscore2
    @highscore2 = @score

  elsif @score >= @highscore3
    @highscore3 = @score

  end


end

def dev args
    args.outputs.labels << [0,700,"Score: "]
    args.outputs.labels << [75,700,@score]
    args.outputs.labels << [0,670,"Life: "]
    args.outputs.labels << [75,670,@life]
    #args.outputs.labels << [75,470,@start]
    #args.outputs.labels << [75,450,@spawndir]
    #args.outputs.labels << [75,430,@spawntime]
    #args.outputs.labels << [75,410,@drop] 
end
  
def player args
    #movement
    if args.inputs.right
    @px += 10
    end 
    if args.inputs.left
    @px -= 10
    end
    args.outputs.solids << [@px,0,50,100,50,250,150]
    args.outputs.borders << @player
    #invisible wall
      if @px <= 0
        @px = 0
      end
      if @px >= 1200
        @px = 1200
      end
end
  
def getscore args
    args.outputs.solids << [@spawnx,600,100,10,100,100,100]
    args.outputs.borders << [@spawnx,600,100,10,0,0,0]
    if @spawndir == 1
      @spawnx -=5
    end
    if @spawndir == 0
      @spawnx +=5
    end
    if @spawnx <= 0
      @spawndir = 0
    end
    if @spawnx >= 1200
      @spawndir = 1
    end
    #gold
    args.outputs.solids << [@goldx, @goldy,25,25,255,256,0]
    args.outputs.borders << @gold
    #timer
  if @start == 1
    if @spawntime <= 0
      @spawntime = 300
      @drop = 1
      @goldx = @spawnx
      else
        @spawntime -= 1
    end
  end
    if @drop == 1
      @goldy == 600
      @goldy -=10
    end
    if @goldy <= 0
      @drop = 0
      @goldy = 600
      @life -=1
    end
   #score go up
    if @gold.intersect_rect? @player
    @score +=1
    @goldy = 600
    @drop = 0
    end
end
  
def tick args
  start args
  var args
  player args
  if @start == 1
    score args  
    getscore args
  end
    dev args
    gameover args
end
