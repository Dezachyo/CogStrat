 function int_target(cfg,target_type)

x=GetSecs; % get function start time

% define index of target type
switch target_type
    case 'object'
        stim_folder = 'image_object';
        waitTime = cfg.time.target;
        stimulus = cfg.rand.encoding{cfg.trialCount,1};
        
    case 'feature'
        stim_folder = 'image_feature';
        waitTime = cfg.time.target;
        stimulus = cfg.rand.encoding{cfg.trialCount,2};
        
    case 'context'
        stim_folder = 'image_context';
        waitTime = cfg.time.target;
        stimulus = cfg.rand.encoding{cfg.trialCount,3};
        
    case 'cue'
        stim_folder = 'image_object';
        waitTime = cfg.time.cue;
        enc_trl  = str2double(cfg.rand.retrieval{cfg.trialCount,1});
        stimulus = cfg.rand.encoding{enc_trl,1};
        
    case 'imagery'        
        % send trigger start
        int_triggerSend(cfg.trigger,target_type)
        img     = imread([cfg.wdir,'stimuli\fixation_bind.jpg']); % read image
        im2txt  = Screen('MakeTexture',cfg.screen.w1,img); % convert image to texture
        Screen('DrawTexture',cfg.screen.w1, im2txt); % draw texture
        Screen('Flip',cfg.screen.w1); % flip
        
        
        time_counter = 0;

        % Wait pre time + jitter

        jitter = cfg.time.jitter*(rand(1));

        WaitSecs(cfg.time.pre + jitter)
        time_counter = time_counter + cfg.time.pre + jitter;

        % Send the 1st TMS pulse 

        for trig = 1:cfg.time.marker_for_pulse
            int_triggerSend(cfg.trigger,'pulse')
        end

        WaitSecs(cfg.time.enable_disable_time) 
        time_counter = time_counter + cfg.time.enable_disable_time;

        for trig = 1:cfg.time.marker_for_pulse
            int_triggerSend(cfg.trigger,'pulse_end')
        end
        
        % Wait in-between pulses

        jitter = cfg.time.jitter*(rand(1));

        WaitSecs(cfg.time.ipi + jitter)
        time_counter = time_counter + cfg.time.ipi + jitter

        % Send the 2nd TMS pulse 

        for trig = 1:cfg.time.marker_for_pulse
            int_triggerSend(cfg.trigger,'pulse')
        end
        
        WaitSecs(cfg.time.enable_disable_time) 
        time_counter = time_counter + cfg.time.enable_disable_time;

        for trig = 1:cfg.time.marker_for_pulse
            int_triggerSend(cfg.trigger,'pulse_end')
        end
        % wait as long as imagery is set
        WaitSecs((x+cfg.time.imagery)-GetSecs);        
        % send trigger end
        int_triggerSend(cfg.trigger,'imagery_end')
        return
        
end

% prepare image
img     = imread([cfg.wdir,'stimuli\',stim_folder,'\',stimulus]); % read image
img     = imresize(img,mean(cfg.screen.img_size./[size(img,1) size(img,2)]));
im2txt  = Screen('MakeTexture',cfg.screen.w1,img); % convert image to texture

% draw texture
Screen('DrawTexture',cfg.screen.w1, im2txt);
Screen('Flip',cfg.screen.w1); % flip

% send trigger
if strcmp(target_type,'imagery' )
else
   int_triggerSend(cfg.trigger,target_type)
end
% wait
WaitSecs((x+waitTime)-GetSecs);
