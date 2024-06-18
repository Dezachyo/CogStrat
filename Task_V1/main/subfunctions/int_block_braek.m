function int_block_braek(cfg)
 
% define cursor position
key_pos = 1;

% draw screen
t1 = int_presentation(cfg,key_pos);

% define 'initial response' variable
t3 = [];

% wait for response
while true
    RestrictKeysForKbCheck([38]);
    resp = 0;
%     [keyIsDown, t2, keyCode, deltaSecs] = KbCheck(0);
    [t2, keyCode, deltaSecs] = KbWait;

    respo = find(keyCode, 1);

%     if respo == 32;
%         resp = 1;
%         WaitSecs(0.25)
%     elseif respo == 13;
%         resp = 2;
%         WaitSecs(0.25)
%         return
%     end
	
    % check for response
%     [resp,t2] = int_getResponse(cfg);
    if isempty(t3); t3=t2; end
        
    % if left key, then move cursor
    if respo == 39
        WaitSecs(0.25)
        % update cursor position
        if key_pos == 1; key_pos = 2;
        else; key_pos = 1;
        end
        % redraw screen with with cursor in new position
         int_presentation(cfg,key_pos);
         
    elseif respo == 37
        WaitSecs(0.25)
        % update cursor position
        if key_pos == 2; key_pos = 1;
        else; key_pos = 2;
        end 
        % redraw screen with with cursor in new position
         int_presentation(cfg,key_pos);

        
    % if right key, the record response
    elseif respo == 38
        WaitSecs(0.25)
        
        % redraw screen with green response
        int_presentation(cfg,key_pos);

        % add trl number to log        
        %log.task_raw{cfg.trialCount,5} = cfg.blockCount;
        
        % switch to pressed key
  
        
        % wait 250ms
        WaitSecs(0.1);
        
        % exit function
        break
    end

    % wait 150ms from button press to avoid rapid key press
    WaitSecs(0.15-(GetSecs-t2))
end
end

function t1 = int_presentation(cfg,key_pos)

if key_pos == 1 % draw left response in red
    [~,~,x] = DrawFormattedText(cfg.screen.w1,'Break Time',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'Break Time',cfg.screen.pos.pleasQ(1)-round(x(3)./2),cfg.screen.pos.pleasQ(2),[0 0 0]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'',cfg.screen.pos.pleasR1(1)-round(x(3)./2),cfg.screen.pos.pleasR1(2),[0 0 0]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'',cfg.screen.pos.pleasR2(1)-round(x(3)./2),cfg.screen.pos.pleasR2(2),[200 200 200]); % draw texture

    t1 = Screen('Flip',cfg.screen.w1); % flip
    
else % draw left response in red
    [~,~,x] = DrawFormattedText(cfg.screen.w1,'Break Time',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'Break Time',cfg.screen.pos.pleasQ(1)-round(x(3)./2),cfg.screen.pos.pleasQ(2),[0 0 0]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'',cfg.screen.pos.pleasR1(1)-round(x(3)./2),cfg.screen.pos.pleasR1(2),[200 200 200]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'',cfg.screen.pos.pleasR2(1)-round(x(3)./2),cfg.screen.pos.pleasR2(2),[0 0 0]); % draw texture

    t1 = Screen('Flip',cfg.screen.w1); % flip   
end

end

