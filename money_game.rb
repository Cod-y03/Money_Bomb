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
    end

    def move_left
        @x -= 10
    end

    def draw
        @image.draw(@x, @y, ZOrder::PLAYER)
    end


    def score
        @score
    end

    def collect_moneys(moneys)
        moneys.reject! do |money| 
            if Gosu.distance(@x, @y, money.x + 10, money.y + 10) < 65 
                @score = @score + 10
                true
            elsif money.y > 700
                true
            else
                false
            end
        end
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

        @background_image = Gosu::Image.new("media/background.png")
        @player = Player.new
        @player.warp(500, 450)
        @font = Gosu::Font.new(20)
        @moneys = Array.new
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

        @player.collect_moneys(@moneys)
 
    end

    def draw
        @background_image.draw(0,0,0)
        @player.draw
        @moneys.each { |money| money.draw}
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