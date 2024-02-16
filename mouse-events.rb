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
            if $pelaretur == 3 && $check == 1
                nextturn
                $exit1 += 1
            elsif $check == 1
                nextturn
            end
            if $exit1 == 5
                $state = 2
            end
            checkaagdklar
        elsif $state == 2
            if $interface == 0  
                for u in 0..$antalLander
                    $lander[u].unclicked
                end
                for i in 0..$antalLander
                    if $lander[i].collission? == true
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
            
                for u in 0..$antalLander
                    $lander[u].unclicked
                end
                for i in 0..$antalLander
                    if $lander[i].collission? == true
                        $lander[i].clicked
                        $lander[i].attacktargets(i)
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
        end
    end
end




on :mouse_down do |event|
    case event.button
    when :right
        if $interface == 0
            intface(0, 10)
        end
    end
end