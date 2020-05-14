blocks = find_system (bdroot, 'BlockType', 'Scope');

  for i = 1: length (blocks)
    set_param (blocks {i}, 'Open', 'on');
  end 
