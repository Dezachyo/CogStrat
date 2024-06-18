function [resp,secs] = int_getResponse(cfg)    

%     % psychtoolbox keyboard constants
%     % KBOARD_CODE_ESC = 27; KBOARD_CODE_SPACE = 32; KBOARD_CODE_ENTER = 13;
%     % KBOARD_CODE_LEFT=37; KBOARD_CODE_UP=38; KBOARD_CODE_RIGHT=39; KBOARD_CODE_DOWN=40;
% 
%     [keyIsDown, secs, keyCode, detlaSecs] = KbCheck(0);
%     D = detlaSecs;
%     TF = keyIsDown;
%     respo = find(keyCode, 1);
%      WaitSecs(0.25)
%     if respo == 37;
%         resp = 1
%     elseif respo == 39;
%         resp =2
%         return
%     end

% loop till broken from
while true
    
    % cycle through buttons
    for button = 1 : 2
        
        
        % get current state      
        [~,cs]  = cfg.lj.ljudObj.eDI(cfg.lj.ljhandle, button+15, 1); % check digital bit 16 (CIO0) and digital bit 17 (CIO1)
        
        % get time
        secs       = GetSecs();
        
        % check if voltage exceeds threshold
        if cs < 1
            resp = button;
            WaitSecs(0.25); % wait to avoid press overlap
            return
        end
    end
end

   