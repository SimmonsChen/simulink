function masktool_neo(block, excelfile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function help to mask parameters and displays into block selected.
% MaskNames should not be the same
% MaskPrompts, MaskNames, MaskStyles, popupcontents, MaskTabs, MaskCallbackStrings
% are written in Excel and this function can automatically transfer them to
% the S-function block.Block masked by this tool can not be edited in Mask
% Editor.
%
% block - the block need to be masked
% excelfile - parameters saved in the excelfile
%
% author: sunzx
% history:
% 2014/08/25 - button, image, text, hyperlink, group supported
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% index definition
promts_index = 1;
names_index = 2;
styles_index = 3;
popups_index = 4;
% tabs_index = 5;
callbacks_index = 6;

% get data in excelfile
[num, str] = xlsread(excelfile);

% get mask prompts and saved as cell format
promts = str(2:end,promts_index);

% get mask names and saved as cell format
names = str(2:end,names_index);
% change names to MaskVariables format

% get mask styles and saved as cell format
styles = str(2:end,styles_index);

% get mask tab names
% tabname = str(2:end, tabs_index);

% get TypeOptions
typeopts = str(2:end, popups_index);

% get callbacks strings
callbackstr = str(2:end, callbacks_index);

% test if gcbh is masked. If masked , delete the old mask and create a
% blank one.
maskobj = Simulink.Mask.get(block);
if ~isempty(maskobj)
    maskobj.delete;
end
maskobj = Simulink.Mask.create(block);

% parameter list value
p_str = [];

% get the object of groupbox "Parameter"
% par_obj = maskobj.getDialogControl('ParameterGroupVar');

% add controls according to the styles.
len = length(names);
for ii = 1:len
    if ismember(styles{ii}, {'text','group','tab'})
        % addDialogControl without callback
        prop = maskobj.addDialogControl(styles{ii},names{ii});
        prop.Prompt = promts{ii};
    elseif ismember(styles{ii}, {'pushbutton','hyperlink'})
        % addDialogControl for Action controls, they have Callback
        prop = maskobj.addDialogControl(styles{ii},names{ii});
        prop.Prompt = promts{ii};
        prop.Callback = callbackstr{ii};
    elseif ismember(styles{ii}, 'image')
        % addDialogControl without Prompt
        prop = maskobj.addDialogControl(styles{ii},names{ii}); 
    elseif ismember(styles{ii},{'edit','checkbox'})   % 'dial','spinbox','slider' only supported in 2014a and later
        % addParameter 
        p_str = [p_str, names{ii}, ','];
        p = maskobj.addParameter('Type', styles{ii}, 'Prompt', promts{ii},'Name', names{ii}, 'Callback', callbackstr{ii});
    elseif ismember(styles{ii}, {'popup','radiobutton'})
        % addParameter for parameters that have TypeOptions
        p_str = [p_str, names{ii}, ','];
        expression = '\|';
        split_str = regexp(typeopts{ii},expression,'split');
        maskobj.addParameter('Type', styles{ii},'TypeOptions', split_str, 'Prompt', promts{ii}, 'Name', names{ii}, 'Callback', callbackstr{ii});  
    end
end

% write S-Function name and parameter-list automatically
set_param(block, 'FunctionName', excelfile);
set_param(block, 'Parameters', p_str(1:end - 1));

disp('Current block is masked automatically.');
