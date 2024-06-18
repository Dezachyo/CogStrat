function log = int_pleasantQ(cfg,log)
 
% define cursor position
key_pos = 1;

% draw screen
t1 = int_presentation(cfg,key_pos);

% define 'initial response' variable
t3 = [];
    % KBOARD_CODE_ESC = 27; KBOARD_CODE_SPACE = 32; KBOARD_CODE_ENTER = 13;
    % KBOARD_CODE_LEFT=37; KBOARD_CODE_UP=38; KBOARD_CODE_RIGHT=39; KBOARD_CODE_DOWN=40;
    
% wait for response
while true
    RestrictKeysForKbCheck([37 39 40 32]);
    resp = 0
%     [keyIsDown, t2, keyCode, deltaSecs] = KbCheck(0);
    [t2, keyCode, deltaSecs] = KbWait;

    respo = find(keyCode, 1)

%     if respo == 32
%         resp = 1
%         WaitSecs(0.25)
%     elseif respo == 13
%         resp = 2
%         WaitSecs(0.25)
%         return
%     end

	
    % check for response
%      [resp,t2] = int_getResponse(cfg);
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
    elseif respo == 32
    
        
        % redraw screen with green response
        int_presentation(cfg,key_pos);

        % add trl number to log        
        log.task_raw{cfg.trialCount,5} = cfg.blockCount;
        
        % switch to pressed key
        switch key_pos
            
            % if pleasant key
            case 1; log.task_raw{cfg.trialCount,6} = 'easy';
                
            % if unpleasant key
            case 2; log.task_raw{cfg.trialCount,6} = 'difficult';                
        end
        
        % add RTs
        log.task_raw{cfg.trialCount,7} = t3-t1; % time to intial response
        log.task_raw{cfg.trialCount,8} = t2-t1; % time to selection
        
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
    [~,~,x] = DrawFormattedText(cfg.screen.w1,'How difficult was it to create the mental image?',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'How difficult was it to create the mental image?',cfg.screen.pos.pleasQ(1)-round(x(3)./2),cfg.screen.pos.pleasQ(2),[0 0 0]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'[ Easy ]',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'[ Easy ]',cfg.screen.pos.pleasR1(1)-round(x(3)./2),cfg.screen.pos.pleasR1(2),[0 0 0]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'[ Difficult ]',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'[ Difficult ]',cfg.screen.pos.pleasR2(1)-round(x(3)./2),cfg.screen.pos.pleasR2(2),[200 200 200]); % draw texture

    t1 = Screen('Flip',cfg.screen.w1); % flip
    
else % draw left response in red
    [~,~,x] = DrawFormattedText(cfg.screen.w1,'How difficult was it to create the mental image?',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'How difficult was it to create the mental image?',cfg.screen.pos.pleasQ(1)-round(x(3)./2),cfg.screen.pos.pleasQ(2),[0 0 0]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'[ Easy ]',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'[ Easy ]',cfg.screen.pos.pleasR1(1)-round(x(3)./2),cfg.screen.pos.pleasR1(2),[200 200 200]); % draw texture

    [~,~,x] = DrawFormattedText(cfg.screen.w1,'[ Difficult ]',[],[],[255 255 255]);
    DrawFormattedText(cfg.screen.w1,'[ Difficult ]',cfg.screen.pos.pleasR2(1)-round(x(3)./2),cfg.screen.pos.pleasR2(2),[0 0 0]); % draw texture

    t1 = Screen('Flip',cfg.screen.w1); % flip   
end

end

