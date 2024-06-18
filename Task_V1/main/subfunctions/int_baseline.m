function int_baseline(cfg)

x=GetSecs; % get function start time

int_triggerSend(cfg.trigger,'contrast_start')

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
%WaitSecs((x + cfg.time.imagery)- GetSecs - time_counter);
WaitSecs((x + cfg.time.imagery)- GetSecs)
int_triggerSend(cfg.trigger,'contrast_end')

