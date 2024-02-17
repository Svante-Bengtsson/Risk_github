require './standard-deploy-phase.rb'

class Land
    attr_reader :crikel, :id, :antal, :agd, :clickread
    
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
        @cont = 0
        @clickread = @clicked.clone
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
                    if $spelare[$pelaretur].index($lander[i].id) == nil
                        $lander[i].attackstate
                    end
                end
            end
        end
    end

    def sned(nuvland)
        arr1 = []
        for i in 0...$attacker[nuvland].length
            if $spelare[$pelaretur].index($attacker[nuvland][i]) != nil && arr1.index($lander[$attacker[nuvland][i]]) == nil
                $lander[$attacker[nuvland][i]].fortify
                arr1.push($lander[$attacker[nuvland][i]])
                for u in 0...$attacker[i].length
                    if $spelare[$pelaretur].index($attacker[i][u]) != nil && arr1.index($lander[$attacker[i][u]]) == nil
                        $lander[$attacker[i][u]].fortify
                        arr1.push($lander[$attacker[i][u]])
                        for o in 0...$attacker[u].length
                            if $spelare[$pelaretur].index($attacker[u][o]) != nil && arr1.index($lander[$attacker[u][o]]) == nil
                                $lander[$attacker[u][o]].fortify
                                arr1.push($lander[$attacker[u][o]])
                                for p in 0...$attacker[o].length
                                    if $spelare[$pelaretur].index($attacker[o][p]) != nil && arr1.index($lander[$attacker[o][p]]) == nil
                                        $lander[$attacker[o][p]].fortify
                                        arr1.push($lander[$attacker[o][p]])
                                        for q in 0...$attacker[p].length
                                            if $spelare[$pelaretur].index($attacker[p][q]) != nil && arr1.index($lander[$attacker[p][q]]) == nil
                                                $lander[$attacker[p][q]].fortify
                                                arr1.push($lander[$attacker[p][q]])
                                                for m in 0...$attacker[q].length
                                                    if $spelare[$pelaretur].index($attacker[q][m]) != nil && arr1.index($lander[$attacker[q][m]]) == nil
                                                        $lander[$attacker[q][m]].fortify
                                                        arr1.push($lander[$attacker[q][m]])
                                                        
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        for i in 0..$antalLander
            $lander[i].clickred
        end
    end

    def attackstate
        @clicked = 3
    end
    
    def unclicked
        @clicked = 0
    end

    def continen
        @cont = 1
    end

    def uncontinen
        @cont = 0
    end

    def felsok
        return @clicked
    end

    def fortify 
        @clicked = 4
    end 

    def clickred
        @clickread = @clicked.clone
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
                
            elsif collission?
                @cirkel.color = @highlight
                
            else 
                if @cont == 1
                    @cirkel.color = @terrcol     
                    

                else
                    @cirkel.color = @farg 
                    
                end
            end
            @clickread = @clicked.clone
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
                if @cont == 1
                    @cirkel.color = @terrcol     
                    

                else
                    @cirkel.color = @farg 
                    
                end
            end
            @clickread = @clicked.clone
        else
            if @clicked == 1
                @cirkel.color = 'black'
            elsif @clicked == 3
                @cirkel.color = 'silver'
            end
        end
    end

    def hover_click_update_fortify
        mousex = Window.mouse_x
        mousey = Window.mouse_y
        if $interface == 0
            if @clicked == 1
                @cirkel.color = 'black'
            elsif @clicked == 3 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == false
                @cirkel.color = @highlight
                
            elsif @clicked == 3 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == true
                @cirkel.color = 'purple'

            elsif @clicked == 4
                @cirkel.color = @highlight

            elsif @clicked == 4 && @cirkel.contains?(Window.mouse_x, Window.mouse_y) == true
                @cirkel.color = 'purple'

            elsif collission?
                @cirkel.color = @highlight
                
            else 
                if @cont == 1
                    @cirkel.color = @terrcol     
                    

                else
                    @cirkel.color = @farg 
                    
                end
            end
            @clickread = @clicked.clone
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