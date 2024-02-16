require './standard-deploy-phase.rb'

class Land
    attr_reader :crikel, :id, :antal, :agd
    
    def start(x, y, id, a, farg, highlight, terr)
        @antal = a
        @x = x
        @y = y
        @id = id
        @farg = farg
        @highlight = highlight
        @terrcol = terr
        @agd = 0
        @clicked = 0
    end


    def updateCirkel(x1, x2, x3, x4, y1, y2, y3, y4)
        @cirkel = Quad.new(
            x1: x1, y1: y1,
            x2: x2, y2: y2,
            x3: x3, y3: y3,
            x4: x4, y4: y4,
            color: 'black',
        )
        crikel = @cirkel
    end


    def soldatnumb
        if @antal.to_s.length == 2
            fakex = @x - 12
        else
            fakex = @x - 6
        end
        @soldnumb = Text.new(
            @antal,
            x: fakex, y: @y - 11,
            color: 'white'
        )


    end
    def nyfarg(fragas, high, terr)
        @farg = fragas
        @highlight = high
        @terrcol = terr

    end
    def fargen
        @cirkel.color = @farg
    end

    def laggsoldater(bussy, land)
        if @agd == 0
            nyfarg($spelare[land][0], $spelare[land][1], $spelare[land][2])
                $spelare[land][$spelare[land].length] = @id
        end
        if $spelare[land].index(@id) == nil
            return 0
        elsif @agd == 1 && $startaagd == 0
            return 0
        else
            
            @antal += bussy
            @soldnumb.text = @antal
            if @antal.to_s.length == 2
                @soldnumb.x = @x -12
            elsif @antal.to_s.length == 1
                @soldnumb.x = @x -6
            elsif @antal.to_s.length == 3
                @soldnumb.x = @x -18
            end
            @agd = 1
            
            return 1
        end
    end
    def sold(soldiers)
        @antal = soldiers
        @soldnumb.text = @antal
    end

    def clicked
        @clicked = 1
    end
    def attacktargets(nuvland)
        for i in 0..$antalLander
            for u in 0..($attacker[nuvland].length - 1)
                if $lander[i].id == $attacker[nuvland][u]
                    $lander[i].attackstate
                end
            end
        end
    end
    def attackstate
        @clicked = 3
    end
    
    def unclicked
        @clicked = 0
    end
    def continen
        @clicked = 4
    end
    def uncontinen
        @clicked = 0
    end

    def hover_click_update_deploy
        mousex = Window.mouse_x
        mousey = Window.mouse_y
        if $interface == 0
            if @clicked == 1
                @cirkel.color = 'black'
            elsif @clicked == 3 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == false
                @cirkel.color = @highlight
                
            elsif @clicked == 3 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == true
                @cirkel.color = 'purple'
                
            elsif @clicked == 4 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == true
                @cirkel.color = @highlight
                
            elsif collission?
                @cirkel.color = @highlight
                
            else 
                if @clicked == 4
                    @cirkel.color = @terrcol     
                    

                else
                    @cirkel.color = @farg 
                    
                end
            end
        else
            if @clicked == 1
                @cirkel.color = 'black'
            elsif @clicked == 3
                @cirkel.color = 'silver'
            end
        end
    end
    
    def hover_click_update_attack
        mousex = Window.mouse_x
        mousey = Window.mouse_y
        if $interface == 0
            if @clicked == 1
                @cirkel.color = 'black'
            elsif @clicked == 3 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == false
                @cirkel.color = @highlight
            elsif @clicked == 3 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == true
                @cirkel.color = 'purple'
            elsif collission?
                @cirkel.color = @highlight
            else 
                @cirkel.color = @farg         
            end
        else
            if @clicked == 1
                @cirkel.color = 'black'
            elsif @clicked == 3
                @cirkel.color = 'silver'
            end
        end
    end


    def collission?
        if @cirkel.contains?(Window.mouse_x, Window.mouse_y) == true
            return true
        else
            return false
        end
    end
    
end