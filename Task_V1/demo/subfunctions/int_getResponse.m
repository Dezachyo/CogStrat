function [resp,secs] = int_getResponse(cfg)

% psychtoolbox keyboard constants
% KBOARD_CODE_ESC = 27; KBOARD_CODE_SPACE = 32; KBOARD_CODE_ENTER = 13;
% KBOARD_CODE_LEFT=37; KBOARD_CODE_UP=38; KBOARD_CODE_RIGHT=39; KBOARD_CODE_DOWN=40;

    RestrictKeysForKbCheck([13 32]);
    resp = 0
%     [keyIsDown, t2, keyCode, deltaSecs] = KbCheck(0);
    [secs, keyCode, deltaSecs] = KbWait();

    respo = find(keyCode, 1)

    if respo == 32
        resp = 1
    elseif respo == 13
        resp = 2
        return
    end
    
end






% was_response_made = false;
% was_key_released = false;
% was_rank_given = false;
% while ( GetSecs() < 6/1000  )
%                 [is_key_down, ~, key_codes_vec, deltaSecs] = KbCheck(0);
%                 deltaSecs ;
%                 t   = deltaSecs;
%                 if (was_key_released && is_key_down)
%                     pressed_key_code = find(key_codes_vec, 1);
%                     if (pressed_key_code == KBOARD_CODE_SPACE && was_rank_given)
%                         was_response_made = true;
%                         elseif 30 < pressed_key_code && pressed_key_code < 40
%                             resp = pressed_key_code
%                             was_rank_given = true;
%                             t   = deltaSecs;
%                     end
%                 elseif ~is_key_down
%                     was_key_released = true;
%                     WaitSecs(0.25); % wait to avoid press overlap
%                     
%                 end
% end
                     
%                         
% pressed_key_code = find(keyCode, 1)
% t      = deltaSecs
% if (is_key_down)                
%             if find(keyCode, 1) == KBOARD_CODE_LEFT
%                 resp = 1;
%             elseif find(keyCode, 1) == KBOARD_CODE_RIGHT
%                 resp = 2;
%                 WaitSecs(0.25); % wait to avoid press overlap
%             end
%             % get time
            
        
    
    
%     t      = deltaSecs;
%     [~,keyCodes] = KbWait;                    
%                 if find(keyCodes, 1) == KBOARD_CODE_LEFT
%                     resp = 1;
%                     break;
%                 elseif find(keyCodes, 1) == KBOARD_CODE_RIGHT
%                     resp = 2;
%                     
%                     break;
%                     WaitSecs(0.25); % wait to avoid press overlap
%                     t       = GetSecs();
%                 end

    
    % cycle through buttons
%     for button = 1 : 2
%         
%         % get current state      
%         [~,cs]  = cfg.lj.ljudObj.eDI(cfg.lj.ljhandle, button+15, 1);
                     % check digital bit 16 (CIO0) and digital bit 17 (CIO1)
%         
%         % get time
%         t       = GetSecs();
%         
%         % check if voltage exceeds threshold
%         if cs < 1
%             resp = button;
%             WaitSecs(0.25); % wait to avoid press overlap
%             return
%         end
%     end
% end
   