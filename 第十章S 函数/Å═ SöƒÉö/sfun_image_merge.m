function sfun_image_merge(block)

setup(block);

function setup(block)
block.BlockHandle
% Register number of ports
block.NumInputPorts  = 2;
block.NumOutputPorts = 0;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;

% Override input port properties
block.InputPort(1).Dimensions        = [375 500];
block.InputPort(1).DatatypeID  = 3;  % uint8
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = false;


block.InputPort(2).Dimensions        = [375 500];

block.InputPort(2).DatatypeID  = 3;  % uint8
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = false;


% Register parameters
block.NumDialogPrms     = 0;

% Register sample times
%  [0 offset]            : Continuous sample time
%  [positive_num offset] : Discrete sample time
%
%  [-1, 0]               : Inherited sample time
%  [-2, 0]               : Variable sample time
block.SampleTimes = [0 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'CustomSimState',  < Has GetSimState and SetSimState methods
%    'DisallowSimState' < Error out when saving or restoring the model sim state
block.SimStateCompliance = 'DefaultSimState';


block.RegBlockMethod('Terminate', @Terminate); % Required


function Terminate(block)
imshow((block.InputPort(1).data + block.InputPort(2).data) / 2);


