require 'gosu'
module ZOrder
    BACKGROUND, MONEY, BOMBS, PLAYER, UI = *0..4
end

class Player
    attr_reader :score
    def initialize
        @image = Gosu::Image.new("media/Player-1.png")
        @x = @y = 0
        @score = 0
    end

    def warp(x, y)
        @x, @y = x, y
    end

    def move_right
        @x += 10
        if @x > 1000
            @x = -90
        end
    end

    def move_left
        @x -= 10
        if @x < -100
            @x = 950
        end
    end

    def draw
        @image.draw(@x, @y, ZOrder::PLAYER)
    end


    def score
        @score
    end

    def collect_moneys(moneys)
        true_x = @x + 50
        true_y = @y
        moneys.reject! do |money| 
            if Gosu.distance(true_x, true_y, money.x + 30, money.y + 10) < 65 
                @score = @score + 10
                true
            elsif money.y > 700
                true
            else
                false
            end
        end
    end
    def collect_bombs(bombs)
        true_x = @x + 50
        true_y = @y + 50
        bombs.reject! do |bomb| 
            if Gosu.distance(true_x, true_y, bomb.x + 30, bomb.y + 10) < 65 
                @game_over = true
                true
            elsif bomb.y > 700
                true
            else
                false
            end
        end
    end

end

class Bomb
    attr_reader :x, :y
    def initialize
        @image =Gosu::Image.new("media/bomb.png")
        @x = rand * 950
        @y = -100
    end 

    def fall
        @y += 3
    end

    def draw
        @image.draw(@x,@y, ZOrder::BOMBS)
        fall
    end 
end

class Money
    attr_reader :x, :y
    def initialize
        @image =Gosu::Image.new("media/money.png")
        @x = rand * 950
        @y = -100
    end 

    def fall
        @y += 3
    end

    def draw
        @image.draw(@x,@y, ZOrder::MONEY)
        fall
    end 
end
class Money_Grab < Gosu::Window

    def initialize
        super 1000, 800
        self.caption = "Money Grab"
        @game_over = false
        @background_image = Gosu::Image.new("media/background.png")
        @end_screen = Gosu::Image.new("media/end_screen.png")
        @player = Player.new
        @player.warp(500, 450)
        @font = Gosu::Font.new(20)
        @moneys = Array.new
        @bombs = Array.new
    end
    def update
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.move_left
        end
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.move_right
        end
        if rand(100) < 2 and @moneys.size < 5
            @moneys.push(Money.new)
        end
        if rand(10) < 2 and @bombs.size < 2
            @bombs.push(Bomb.new)
        end
        @player.collect_moneys(@moneys)
        @player.collect_bombs(@bombs)
        if @game_over == true
            game_end(@score)
        end
 
    end



    def game_end(score)
        @background_image = @end_screen
    end
    def draw
        @background_image.draw(0,0,0)
        @player.draw
        @moneys.each { |money| money.draw}
        @bombs.each { |bomb| bomb.draw}
        @font.draw_text("Player 1 Score: #{@player.score}", 10, 10, ZOrder::UI, 1.5, 1.5, Gosu::Color::YELLOW)
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        else
            super
        end
    end

end

Money_Grab.new.show