require './standard-deploy-phase.rb'

# Det här är klassen som kontrollerar alla länder och all och det mesta som görs med länderna pågår här inne. varje land i listan $lander definieras som ett land i denna classen och ges ett id som är samma som landets plats i $lander.
# jag har några funktioner som framförallt initierar olika variabler, den viktigaste är .start som initierar alla relativa grundvariabler. sen finns det också .updateCirkel som är den som ritar "spritesen". sen har jag några funktioner som håller koll på färg och soldater som körs kontinuerligt beroende på var i spelet man befinner sig.
# dessa är hover_click_update_deploy, attack och fortify. det finns också ett antal funktioner som ändrar @clicked till olika saker, dessa behövs så att jag kan sätta vissa länder som klickade
# den sista viktiga funktionen är .collossion? vilken kollar om musen hovrar över landet, jag skapade en specifik metod för detta då jag använder det så mycket.

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
        arr1.push(nuvland)
        fdland = nuvland.clone
        for o in 0..10
            for i in 0...$lander.length
                if $spelare[$pelaretur].index($lander[i].id)  && arr1.index($lander[i].id) == nil
                    for u in 0...arr1.length
                        if $attacker[arr1[u]].index($lander[i].id) != nil
                            arr1.push(i)
                        end
                    end
                end
            end
        end
        for i in 0...arr1.length
            $lander[arr1[i]].fortify
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