function masktool(block, excelfile)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function help to mask parameters into block selected.
% MaskNames should not be the same
% MaskPrompts, MaskNames, MaskStyles, popupcontents, MaskTabs, MaskCallbackStrings
% are written in Excel and this function can automatically transfer them 
%
% block - the block need to be masked
% excelfile - parameters saved in the excelfile
%
% author: sunzx
% update date: 2013/07/29
%              2014/08/23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% index definition
promts_index = 1;
names_index = 2;
styles_index = 3;
popups_index = 4;
tabs_index = 5;
callbacks_index = 6;

% get data in excelfile
[num, str] = xlsread(excelfile);

% get mask prompts and saved as cell format
promts = str(2:end,promts_index);

% get mask names and saved as cell format
names = str(2:end,names_index);
% change names to MaskVariables format
len = length(names);
maskvar = '';
for ii = 1 : len
    maskvar = [maskvar, names{ii}, '=@', num2str(ii), ';']; %OK
end

% get mask styles and saved as cell format
styles = str(2:end,styles_index);

% get mask tab names
tabname = str(2:end, tabs_index); 

% get callbacks strings
callbackstr = str(2:end, callbacks_index);

%get block's handle
blockhandle = get_param(block,'Handle');

% get model properties
prop = get(blockhandle);

% mask promts into block
set_param(blockhandle, 'MaskPrompts', promts);

% mask names into block (MaskNames or MaskPropertyNameString is a readonly property)
%set_param(blockhandle, 'MaskNames', names);
set_param(blockhandle, 'MaskVariables', maskvar);

% mask styles intoblock
set_param(blockhandle, 'MaskStyles', styles);

% check popup to write strings 
style = str(2:end, styles_index);

% get popup strings 
popups = str(2:end, popups_index);
% popuplen = length(popups);
% for ii = 1 :popuplen
%    str2pro = popups{ii};
%    str2pro(findstr(popups{ii} ,char(10))) = '';  %char(10) = line change token, delete it
%    popups{ii} = str2pro;
% end

% get MaskStyleString 
stylestring = get_param(blockhandle, 'MaskStyleString');

% get empty start index from MaskStyleString and its length and its total number
emptystart = regexp(stylestring,'<empty>');
lenempty = length('<empty>');
if ~isempty(emptystart)
    numtorep = length(emptystart);

    % draw popup content from excelfile
    content = cell(numtorep);
    count = 1; 
    num = length(style);
    for ii = 1:num
        if strcmp(style{ii}, 'popup')||strcmp(style{ii}, 'radiobutton')
            content{count} = str(ii + 1, popups_index);
            % content keep format as xxx|xxx|xxx
            count = count + 1;
        end
    end
end

% part stylestring to seperate parts 
% create cell using () not {}
if ~isempty(emptystart)
    strpart = cell(numtorep + 1);
    strpart{1} = stylestring(1: emptystart(1) - 1);
    for ii = 2 : numtorep
        strpart{ii} = stylestring(emptystart(ii-1) + lenempty :emptystart(ii) - 1);

    end
    strpart{numtorep + 1} = stylestring(emptystart(end) + lenempty : end);

    % insert content into strpart
    maskstring =strpart{1};
    for ii = 1: numtorep
        maskstring = strcat(maskstring, content{ii});
        maskstring = strcat(maskstring, strpart{ii + 1});
    end

    % cell changed to string 
    stylestring = char(maskstring);
    % delete char(10) (which is not \n or \r)
    stylestring(findstr(stylestring, char(10))) = '';  %delete char(10) change line token
    

    % set MaskStyleString into block
    set_param(blockhandle, 'MaskStyleString', stylestring);
end

% set tab names
set_param(blockhandle, 'MaskTabNames', tabname);

% format callback str to xx|xx|xx|xx style but not display in callback dialog
% cbnum = length(callbackstr);
% cbstr = '';
% for ii = 1:cbnum
%     cbstr = [cbstr, callbackstr{ii},'|'];
% end
% cbstr

% set MaskCallbacks
set_param(blockhandle, 'MaskCallbacks', callbackstr);

% get model name 
modelname = get_param(blockhandle, 'Name');
%modelpath = get_param(blockhandle, 'Path');
%fullname = fullfile(modelpath, modelname);

% write Parameters automatically
paramstr = get_param(blockhandle, 'MaskPropertyNameString');
paramstr(findstr(paramstr,'|')) = ',';
set_param(blockhandle, 'Parameters', paramstr);

% write S-Function name automatically
set_param(blockhandle, 'FunctionName', excelfile);

% print OK info
disp([modelname, ' Mask Over!']);