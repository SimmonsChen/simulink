function blkStruct = slblocks
% Information for "Blocksets and Toolboxes" subsystem
blkStruct.Name = sprintf('Just for fun!');
blkStruct.OpenFcn = 'disp(''Open Entertainment Toolbox.'')';
blkStruct.MaskDisplay = 'plot([0:2*pi],sin([0:2*pi]));';

% Information for Simulink Library Browser
Browser(1).Library = 'Entertainment';  % no extension name
Browser(1).Name    = 'Entertainment Toolbox @hyowinner';
Browser(1).IsFlat  = 0;  % no subsystems

blkStruct.Browser = Browser;