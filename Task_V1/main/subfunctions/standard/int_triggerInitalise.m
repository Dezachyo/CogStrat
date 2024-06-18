function trig = int_triggerInitalise()

trig.PortAddress = hex2dec('5EFC'); %check this port address!
trig.ioObjTrig = io64;

% initialize the interface to the inpoutx64 system driver
trig.status = io64(trig.ioObjTrig);

%send 0 trigger (reset all pins)
io64(trig.ioObjTrig,trig.PortAddress,0); %trigger 0 (reset)
io64(trig.ioObjTrig,trig.PortAddress,1); %trigger 0 (reset)

io64(trig.ioObjTrig,trig.PortAddress, 45)

% define trigger values
trig.object  = 31;
trig.feature = 32;
trig.context = 33;
trig.imagery = 51;
trig.imagery_end = 52;
trig.contrast_start = 61;
trig.contrast_end = 62;
trig.pulse = 100;
trig.pulse_end = 101;
trig.cue     = 41;
trig.distract_start = 91;
trig.distract_end = 92;

%% Send Test Pulses

%trig_vals = {'object','feature','context','imagery','imagery_end','cue'};
%for i = 1 : numel(trig_vals)
%    int_triggerSend(trig,trig_vals{i});
%    WaitSecs(0.05);
%end
