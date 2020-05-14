set_param('m_control_04','SolverType','Fixed-step','Solver','FixedStepDiscrete','FixedStep','0.1');
set_param('m_control_04', 'SimulationCommand', 'start');
set_param('m_control_04', 'SimulationCommand', 'pause');
set_param('m_control_04', 'SimulationCommand', 'step');
pause(0.2);
t = get_param('m_control_04', 'SimulationTime')  % get current simulation time
while t~=0
    t = get_param('m_control_04', 'SimulationTime');  % get current simulation time
    if t < 30
        set_param('m_control_04/Gain', 'Gain','3');
    elseif t < 80
        set_param('m_control_04/Gain', 'Gain','1.5');
    else
        set_param('m_control_04/Gain', 'Gain','-0.3');
    end
    set_param('m_control_04', 'SimulationCommand', 'step');
    pause(0.2);
end
set_param('m_control_04', 'SimulationCommand', 'stop');
