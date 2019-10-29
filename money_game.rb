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
        @image.draw(@x, @y, 1)
    end
end

class Money
    attr_raeder :x, :y
    def initialize
        @image =Gosu::Image.new("media/money.png")
        @x = rand * 1000
        @y = 900
    end 

    def draw


class Money_Grab < Gosu::Window

    def initialize
        super 1000, 800
        self.caption = "Money Grab"

        @background_image = Gosu::Image.new("media/background.png")
        @player = Player.new
        @player.warp(500, 450)
    end
    def update
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.move_left
        end
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.move_right
        end

    end

    def draw
        @background_image.draw(0,0,0)
        @player.draw

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