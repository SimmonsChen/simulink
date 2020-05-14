set_param('m_control_05','SimulationCommand','start');
scope_h = find_system('m_control_05', 'findall','on','blockType','Scope');
num_scope = length(scope_h);
for ii = 1: num_scope
    set(scope_h(ii), 'Open', 'on');
end