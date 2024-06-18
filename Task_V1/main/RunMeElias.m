 

function RunMe()
% CONTINUE WITH test3Phase - need to pass the data folder to get the
% tests functions for the study expdata

close all; 
clear all;


Screen('CloseAll');

WORDS_FULL_PATH = fullfile('resources','stimuli','words.xlsx');
PRACTICE_WORDS_FULL_PATH = fullfile('resources','stimuli','practice_words.xlsx');
PARAMS_STRUCT.msgs_folder= fullfile('..','resources','instructions');
PARAMS_STRUCT.pics_folder= fullfile('..','resources','stimuli','pics'); 


DATA_FILES_SAVE_FOLDER = fullfile('..','data_files');
EXPDATA_SAVE_FILE_NAME_PREFIX='behavioral';
ENUM_START_PHASE_STUDY_PHASE= 0;
ENUM_START_PHASE_TEST1_PHASE= 1;
ENUM_START_PHASE_TEST2_PHASE= 2;
ENUM_START_PHASE_TEST3_PHASE= 3; 
ENUM_EXPERIMENT_DAY_1= 1;

ENUM_EXPERIMENT_DAY_2= 2;
ENUM_EXPERIMENT_DAY_3= 3;


GUI_BACKGROUND_COLOR= [1.0, 1.0, 1.0];
SUBJECT_NUMBER = 0;
BLOCKS_NUMBER = 2;
SUBJECT_AGE = 20;
SUBJECT_GENDER = 'Woman';
SELECTED_EXPERIMENT_DAY = ENUM_EXPERIMENT_DAY_1;
SELECTED_START_PHASE= ENUM_START_PHASE_STUDY_PHASE;
SWAP_TESTS_1_AND_2 = false;
ROOT_DIR= pwd;
IS_EXP_GO = true;

fig= figure('Visible', 'on', 'units', 'normalized', ...
    'name', 'Directed Forgetting', 'NumberTitle', 'off', ...
    'Position', [0.4, 0.4, 0.4, 0.4], ...
    'MenuBar', 'none', ...
    'color', GUI_BACKGROUND_COLOR);
    
    % subject number
    button_group_subject_number= uipanel('tag', 'sn', ...
        'Position', [0.08, 0.85, 0.2, 0.075], ...
        'Background', GUI_BACKGROUND_COLOR, ...        
        'BorderWidth', 0);

    uicontrol(button_group_subject_number, 'Style','text', 'units', 'normalized', ...
        'String', 'Subject Number', ...
        'Position', [0.05, 0.4, 0.8, 0.45], ...
        'FontSize', 10.0, ...
        'BackgroundColor', GUI_BACKGROUND_COLOR);

    uicontrol(button_group_subject_number, 'Style', 'edit', 'units', 'normalized', ...
        'String', num2str(SUBJECT_NUMBER), ...
        'position', [0.8, 0.05, 0.15, 0.9], ...
        'callback', @subjectNumberUpdated);
    
    % subject age
    button_group_subject_number= uipanel('tag', 'sa', ...
        'Position', [0.3, 0.85, 0.2, 0.075], ...
        'Background', GUI_BACKGROUND_COLOR, ...        
        'BorderWidth', 0);

    uicontrol(button_group_subject_number, 'Style','text', 'units', 'normalized', ...
        'String', 'Subject Age', ...
        'Position', [0.05, 0.4, 0.8, 0.45], ...
        'FontSize', 10.0, ...
        'BackgroundColor', GUI_BACKGROUND_COLOR);

    uicontrol(button_group_subject_number, 'Style', 'edit', 'units', 'normalized', ...
        'String', num2str(SUBJECT_AGE), ...
        'position', [0.8, 0.05, 0.15, 0.9], ...
        'callback', @subjectAgeUpdated);

    % subject gender
    button_group= uibuttongroup('tag', 'sg', ...
        'Position', [0.55, 0.78, 0.15, 0.2], ...
        'BackgroundColor', GUI_BACKGROUND_COLOR, ...
        'SelectionChangeFcn', @subjectGenderUpdated);
    
    uicontrol(button_group, 'Style','text', 'units', 'normalized', ...
        'String', 'Subject Gender', ...
        'Position', [0.075, 0.2, 0.4, 0.4], ...
        'FontSize', 10.0, ...
        'BackgroundColor', GUI_BACKGROUND_COLOR);
            
    uicontrol(button_group, 'Style', 'radiobutton', ...
                    'units', 'normalized', 'String', 'Woman', ...
                    'Value', true, ...
                    'Position', [0.6, 0.6, 0.25 ,0.3], ...
                    'FontSize', 10.0, ... 
                    'UserData', 'Female', ...
                    'BackgroundColor', GUI_BACKGROUND_COLOR);
                
    uicontrol(button_group, 'Style', 'radiobutton', ...
                    'units', 'normalized', 'String', 'Man', ...
                    'Value', false, ...
                    'Position', [0.6, 0.1, 0.25 ,0.3], ...
                    'FontSize', 10.0, ... 
                    'UserData', 'Female', ...
                    'BackgroundColor', GUI_BACKGROUND_COLOR);
                
                
     % Blocks Number
    button_group_subject_number= uipanel('tag', 'sn', ...
        'Position', [0.08, 0.85, 0.2, 0.075], ...
        'Background', GUI_BACKGROUND_COLOR, ...        
        'BorderWidth', 0);

    uicontrol(button_group_subject_number, 'Style','text', 'units', 'normalized', ...
        'String', 'Blocks Number', ...
        'Position', [0.05, 0.4, 0.8, 0.45], ...
        'FontSize', 10.0, ...
        'BackgroundColor', GUI_BACKGROUND_COLOR);

    uicontrol(button_group_subject_number, 'Style', 'edit', 'units', 'normalized', ...
        'String', num2str(BLOCKS_NUMBER), ...
        'position', [0.8, 0.05, 0.15, 0.9], ...
        'callback', @subjectNumberUpdated);

                

                
    % start and cancel buttons
    uicontrol(fig, 'Style', 'pushbutton', 'tag', 'sb', 'units', 'normalized', ...
        'String', 'Go', ...
        'Position', [0.05   0.05    0.4    0.15], ...
        'FontSize', 14.0, ...
        'callback', {@goBtnCallback});
    
    uicontrol(fig, 'Style', 'pushbutton', 'tag', 'cb', 'units', 'normalized', ...
        'String', 'Cancel', ...
        'Position', [0.55   0.05    0.4    0.15], ...
        'FontSize', 14.0, ...
        'callback', {@cancelBtnCallback});   
    
    
        
    function subjectNumberUpdated(hObject, event_data)
        input = get(hObject,'string');        
        if isStrAValidNonNegativeInteger(input)
            SUBJECT_NUMBER= num2str(input);
        else
            set(hObject, 'string', PARAMS_STRUCT);
        end
    end

    function subjectAgeUpdated(hObject, event_data)
        input = get(hObject,'string');
        if isStrAValidNonNegativeInteger(input)
            SUBJECT_AGE= num2str(input);
        else
            set(hObject, 'string', SUBJECT_AGE);
        end  
    end

    function subjectGenderUpdated(~, event_data)        
        SUBJECT_GENDER = get(event_data.NewValue,'UserData');
    end


    function startPhaseUpdatedCallback(~, event_data)
        SELECTED_START_PHASE= get(event_data.NewValue, 'UserData');
    end   



    function res= isStrAValidNonNegativeInteger(str)
        if ~isempty(str) && isempty(find(~isstrprop(str,'digit'),1))
            if numel(str)==1 || ~strcmp(str(1),'0')
                res= true;
            else
                res= false;
            end
        else
            res= false;
        end
    end
    
    function [is_file_unique, user_response]= verifyFileUniqueness(file_name)        
        user_response= [];
        if exist(file_name,'file')
            is_file_unique= false;
            user_response = questdlg(['File "' file_name '" already exists. How to proceed?'],'Confirm save file name','Overwrite','Cancel','Cancel');            
        else
            is_file_unique= true;
        end
    end
    
    function annotation= annotateFileDuplication(file_name_without_ext, file_ext)
        does_file_exist= exist([file_name_without_ext, file_ext], 'file');
        duplicates_nr= 0;
        annotation= [];
        while (does_file_exist)
            duplicates_nr= duplicates_nr + 1;
            annotation= [' - duplicate ', num2str(duplicates_nr)];
            does_file_exist= exist([file_name_without_ext, annotation, file_ext],'file');
        end
    end

    function goBtnCallback(~, ~)                          
        close(fig);
        cd(ROOT_DIR);         
        PARAMS_STRUCT.words = loadWords(WORDS_FULL_PATH);
        PARAMS_STRUCT.practice_words = loadWords(PRACTICE_WORDS_FULL_PATH);                
        PARAMS_STRUCT.subject_number = SUBJECT_NUMBER;
        PARAMS_STRUCT.subject_age = SUBJECT_AGE;
        PARAMS_STRUCT.subject_gender = SUBJECT_GENDER;
        if SELECTED_EXPERIMENT_DAY == ENUM_EXPERIMENT_DAY_3
            if ~exist(fullfile('data_files', 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']) ,'file')
                errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no study phase data file.']);
                return;
            end
            [is_file_unique, user_response]= verifyFileUniqueness(fullfile('data_files', 'pictures ranking', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'pictures_ranking', '.mat']));
            if ~is_file_unique && strcmp(user_response,'Cancel')                
                return;
            end
            
            PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'pictures ranking', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'pictures_ranking', '.mat']);                                    
            PARAMS_STRUCT.study_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']);                                    
            cd('pictures ranking');
        	IS_EXP_GO = picturesRanking(PARAMS_STRUCT);                                
            cd(ROOT_DIR);
            return;
        end
        
        if SELECTED_START_PHASE == ENUM_START_PHASE_STUDY_PHASE             
            [is_file_unique, user_response]= verifyFileUniqueness(fullfile('data_files', 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']));
            if ~is_file_unique && strcmp(user_response,'Cancel')                
                return;
            end
            
            PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']);                                    
            cd('study phase');

            
            [IS_EXP_GO, GUI_PARAMS, PSYCHTOOLBOX_OBJS] = studyPhase(PARAMS_STRUCT);                                
            cd(ROOT_DIR);
            
            if IS_EXP_GO                
                PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'masking task phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'masking', '.mat']);
                cd('masking task phase');
                IS_EXP_GO = maskingTask(PARAMS_STRUCT, GUI_PARAMS, PSYCHTOOLBOX_OBJS);                                
                cd(ROOT_DIR);
            else
                ShowCursor();
                Screen('CloseAll')
                commandwindow;
            end
        end                                  
        
        PARAMS_STRUCT.selected_experiment_day = SELECTED_EXPERIMENT_DAY;
        if ~SWAP_TESTS_1_AND_2                    
            if IS_EXP_GO && (SELECTED_START_PHASE == ENUM_START_PHASE_STUDY_PHASE || ...
                             SELECTED_START_PHASE == ENUM_START_PHASE_TEST1_PHASE)
                if ~exist(fullfile('data_files', 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']) ,'file')
                    errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no study phase data file.']);
                    return;
                end
                if PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_1
                    expdata_save_file_name_suffix = 'test1day1';
                else
                    expdata_save_file_name_suffix = 'test1day2';
                end
                [is_file_unique, user_response]= verifyFileUniqueness(fullfile('data_files', 'test1phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.xlsx']));
                if ~is_file_unique && strcmp(user_response,'Cancel')                
                    return;
                end

                PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'test1phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.xlsx']);
                PARAMS_STRUCT.study_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']);            
                cd(fullfile(ROOT_DIR, 'test1 phase'));
                IS_EXP_GO = test1Phase(PARAMS_STRUCT);            
                cd(ROOT_DIR);
            end

            if IS_EXP_GO && (SELECTED_START_PHASE == ENUM_START_PHASE_STUDY_PHASE || ...
                             SELECTED_START_PHASE == ENUM_START_PHASE_TEST1_PHASE || ...
                             SELECTED_START_PHASE == ENUM_START_PHASE_TEST2_PHASE)            
                if PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_1 && ~exist(fullfile('data_files', 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']) ,'file')
                    errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no study phase data file.']);
                    return;            
                elseif PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_2 && ~exist(fullfile('data_files', 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'test2day1', '.mat']) ,'file')
                    errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no data file from day #1 for test phase 2.']);
                    return;
                end

                if PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_1
                    expdata_save_file_name_suffix = 'test2day1';                
                else
                    expdata_save_file_name_suffix = 'test2day2';
                    PARAMS_STRUCT.prev_day_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'test2day1', '.mat']);                
                end    
                [is_file_unique, user_response]= verifyFileUniqueness(fullfile('data_files', 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.mat']));
                if ~is_file_unique && strcmp(user_response,'Cancel')                
                    return;
                end

                PARAMS_STRUCT.study_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']);
                PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.mat']);            

                cd(fullfile(ROOT_DIR, 'test2 phase'));
                IS_EXP_GO = test2Phase(PARAMS_STRUCT);    
                cd(ROOT_DIR);
            end
        else
            if IS_EXP_GO && (SELECTED_START_PHASE == ENUM_START_PHASE_STUDY_PHASE || ...
                             SELECTED_START_PHASE == ENUM_START_PHASE_TEST1_PHASE || ...
                             SELECTED_START_PHASE == ENUM_START_PHASE_TEST2_PHASE)            
                if PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_1 && ~exist(fullfile('data_files', 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']) ,'file')
                    errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no study phase data file.']);
                    return;            
                elseif PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_2 && ~exist(fullfile('data_files', 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'test2day1', '.mat']) ,'file')
                    errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no data file from day #1 for test phase 2.']);
                    return;
                end

                if PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_1
                    expdata_save_file_name_suffix = 'test2day1';                
                else
                    expdata_save_file_name_suffix = 'test2day2';
                    PARAMS_STRUCT.prev_day_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'test2day1', '.mat']);                
                end    
                [is_file_unique, user_response]= verifyFileUniqueness(fullfile('data_files', 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.mat']));
                if ~is_file_unique && strcmp(user_response,'Cancel')                
                    return;
                end

                PARAMS_STRUCT.study_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']);
                PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'test2 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.mat']);            

                cd(fullfile(ROOT_DIR, 'test2 phase'));
                IS_EXP_GO = test2Phase(PARAMS_STRUCT);    
                cd(ROOT_DIR);
            end
            
            PARAMS_STRUCT.selected_experiment_day = SELECTED_EXPERIMENT_DAY;
            if IS_EXP_GO && (SELECTED_START_PHASE == ENUM_START_PHASE_STUDY_PHASE || ...
                             SELECTED_START_PHASE == ENUM_START_PHASE_TEST1_PHASE)
                if ~exist(fullfile('data_files', 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']) ,'file')
                    errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no study phase data file.']);
                    return;
                end
                if PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_1
                    expdata_save_file_name_suffix = 'test1day1';
                else
                    expdata_save_file_name_suffix = 'test1day2';
                end
                [is_file_unique, user_response]= verifyFileUniqueness(fullfile('data_files', 'test1phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.xlsx']));
                if ~is_file_unique && strcmp(user_response,'Cancel')                
                    return;
                end

                PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'test1phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.xlsx']);
                PARAMS_STRUCT.study_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']);            
                cd(fullfile(ROOT_DIR, 'test1 phase'));
                IS_EXP_GO = test1Phase(PARAMS_STRUCT);            
                cd(ROOT_DIR);
            end                        
        end
        
        if IS_EXP_GO && (SELECTED_START_PHASE == ENUM_START_PHASE_STUDY_PHASE || ...
                         SELECTED_START_PHASE == ENUM_START_PHASE_TEST1_PHASE || ...
                         SELECTED_START_PHASE == ENUM_START_PHASE_TEST2_PHASE || ...
                         SELECTED_START_PHASE == ENUM_START_PHASE_TEST3_PHASE)            
            if ~exist(fullfile('data_files', 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']) ,'file')
                errordlg(['Subject #', num2str(SUBJECT_NUMBER), ' has no study phase data file.']);
                return;            
            end
            
            if PARAMS_STRUCT.selected_experiment_day == ENUM_EXPERIMENT_DAY_1
                expdata_save_file_name_suffix = 'test3day1';                
            else
                expdata_save_file_name_suffix = 'test3day2';                
            end  
            [is_file_unique, user_response]= verifyFileUniqueness(fullfile('data_files', 'test3 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.mat']));
            if ~is_file_unique && strcmp(user_response,'Cancel')                
                return;
            end
            
            PARAMS_STRUCT.study_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'study phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), 'study', '.mat']);
            PARAMS_STRUCT.full_save_path = fullfile(DATA_FILES_SAVE_FOLDER, 'test3 phase', [EXPDATA_SAVE_FILE_NAME_PREFIX, num2str(SUBJECT_NUMBER), expdata_save_file_name_suffix, '.mat']);                                  
                        
            cd(fullfile(ROOT_DIR, 'test3 phase'));
            test3Phase(PARAMS_STRUCT);         
            cd(ROOT_DIR);
        end  
        
        function words_cell_arr = loadWords(words_xlsx_full_path)
            words_struct= table2struct(readtable(words_xlsx_full_path));            
            valid_words_it = 1;
            for word_idx = 1:numel(words_struct)
                if ~isempty(words_struct(word_idx).L1)
                    words_cell_arr{valid_words_it, 1} = words_struct(word_idx).L1;
                    words_cell_arr{valid_words_it, 2} = words_struct(word_idx).L2;
                    valid_words_it = valid_words_it + 1;
                end
            end
        end
    end

    function cancelBtnCallback(~, ~)
        close(fig);
    end      

end
