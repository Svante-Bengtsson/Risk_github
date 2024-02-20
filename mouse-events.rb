on :mouse_down do |event|
    case event.button
    when :left
        if $state == 1
            $check = 0
            for i in 0..$antalLander
                if $lander[i].collission? == true
                    $check = $lander[i].laggsoldater(1, $pelaretur)
                end
            end
            if $pelaretur == $antalpelareclock && $check == 1
                nextturn
                $exit1 += 1
            elsif $check == 1
                nextturn
            end
            if $exit1 == $exitinitdepl
                $state = 2
            end
            checkaagdklar
        elsif $state == 2
            if $interface == 0  
                for u in 0..$antalLander
                    $lander[u].unclicked
                end
                for i in 0..$antalLander
                    if $lander[i].collission? == true && $spelare[$pelaretur].include?($lander[i].id) == true
                        $lander[i].clicked
                        $othersold = $lander[i].antal
                        $curland = $lander[i].id
                        intface($cursoldiers, $othersold)
                    end
                end
            else
                if @intcirc3.contains?(Window.mouse_x, Window.mouse_y) 
                    @soldmenu= 1
                elsif @intcirc2.contains?(Window.mouse_x, Window.mouse_y) 
                    @soldmenu= 2
                elsif @intcirc1.contains?(Window.mouse_x, Window.mouse_y)
                    @soldmenu= 3
                end
            end
        elsif $state == 3
            if $interface == 0  
                
                hovercheck = 0
                for i in 0..$antalLander
                    if $lander[i].collission? == true
                        hovercheck = 1
                    end
                end
                if hovercheck == 0
                    $clickstate3 = 0
                    $savestateattack = nil
                    for i in 0..$antalLander
                        $lander[i].unclicked
                    end
                end
                for i in 0..$antalLander
                    if $lander[i].collission? == true && $spelare[$pelaretur].include?($lander[i].id) == true && $clickstate3 == 0 && $lander[i].antal > 1
                        $lander[i].attacktargets(i)
                        $lander[i].clicked
                        $clickstate3 = 1
                        $savestateattack = $lander[i].id
                    elsif $savestateattack == nil
                        #vet ej vad som hände här men det löste en bugg
                    elsif $lander[i].collission? == true && $attacker[$savestateattack].include?($lander[i].id) == true && $spelare[$pelaretur].include?($lander[i].id) == false && $clickstate3 == 1
                        arr = attackera($savestateattack, $lander[i].id)
                        if arr[0] == 1
                            $lander[$savestateattack].sold(arr[0])
                            $lander[i].sold(arr[1])
                            $savestateattack = nil
                            $attackedsave = nil
                            for o in 0..$antalLander
                                $lander[o].unclicked
                            end
                        elsif arr[1] == 0
                            for u in 0..$antalpelareclock
                                $spelare[u].delete(i)
                            end
                            $spelare[$pelaretur].push(i)
                            $lander[$savestateattack].sold(arr[0])
                            $lander[i].sold(0)
                            $lander[i].nyfarg($spelare[$pelaretur][0], $spelare[$pelaretur][1], $spelare[$pelaretur][2])
                            continents(0)
                            arr2 = intface((arr[0].to_i - 1), (arr[1].to_i + 1))
                            $attackedsave = i
                        end
                    end
                end
                if @knappcirc.contains?(Window.mouse_x, Window.mouse_y)
                    $state = 4
                    @knappcirc.remove
                    @knappL.remove
                    createbutton2
                end
            else
                if @intcirc3.contains?(Window.mouse_x, Window.mouse_y) 
                    @soldmenu= 1
                elsif @intcirc2.contains?(Window.mouse_x, Window.mouse_y) 
                    @soldmenu= 2
                elsif @intcirc1.contains?(Window.mouse_x, Window.mouse_y)
                    @soldmenu= 3
                end
            end
        elsif $state == 4
            if $interface == 0  
                
                hovercheck = 0
                for i in 0..$antalLander
                    if $lander[i].collission? == true
                        hovercheck = 1
                    end
                end
                if hovercheck == 0
                    $clickstate3 = 0
                    $savestateattack = nil
                    for i in 0..$antalLander
                        $lander[i].unclicked
                    end
                end
                for i in 0..$antalLander
                    if $lander[i].collission? == true && $spelare[$pelaretur].include?($lander[i].id) == true && $clickstate3 == 0 && $lander[i].antal > 1
                        $lander[i].sned(i)
                        $lander[i].clicked
                        $clickstate3 = 1
                        $savestateattack = $lander[i].id
                    elsif $savestateattack == nil
                        #vet ej vad som hände här men det löste en bugg
                    elsif $lander[i].collission? == true && $lander[i].clickread == 4 && $spelare[$pelaretur].include?($lander[i].id) == true && $clickstate3 == 1
                        arr = [$savestateattack, $lander[i].id]
                        $attackedsave = i
                        arr2 = intface($lander[arr[0]].antal, $lander[arr[1]].antal)
                        
                    
                    end
                end
                if @knappcirc2.contains?(Window.mouse_x, Window.mouse_y)
                    $state = 2
                    @knappcirc2.remove
                    @knappL2.remove
                    nextturn
                    $deployphase = 0
                end
            else
                if @intcirc3.contains?(Window.mouse_x, Window.mouse_y) 
                    @soldmenu= 1
                elsif @intcirc2.contains?(Window.mouse_x, Window.mouse_y) 
                    @soldmenu= 2
                elsif @intcirc1.contains?(Window.mouse_x, Window.mouse_y)
                    @soldmenu= 3
                end
            end
        end
    end
end