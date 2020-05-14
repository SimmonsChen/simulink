%% Define the schema function for first menu item.
function schema = menu_control(callbackInfo)
schema = sl_container_schema;
schema.label = 'Hyo Customized';
schema.childrenFcns = {@get_block_property;}
end

% function schema2 = get_block_property(callbackInfo)
% schema2 = sl_action_schema;
% schema2.label = 'block property';
% schema2.userdata = 'Hyo Custom';
% schema2.childrenFcns = {@custom_callback;}
% end

function custom_callback(callbackInfo)
inspect(gcbh);
disp('### The property of current block is displayed.');
end