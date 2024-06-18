function int_fixation(cfg)

img     = imread([cfg.wdir,'stimuli\fixation_bind.jpg']); % read image
im2txt  = Screen('MakeTexture',cfg.screen.w1,img); % convert image to texture
Screen('DrawTexture',cfg.screen.w1, im2txt); % draw texture
Screen('Flip',cfg.screen.w1); % flip


% wait fixation 5 secs
WaitSecs(5);
