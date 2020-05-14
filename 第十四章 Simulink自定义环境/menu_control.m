%% Define the schema function for first menu item.
function schema = menu_control(callbackInfo)
schema = sl_container_schema;
schema.label = 'Hyo Customized';
schema.childrenFcns = {@get_block_property;}
end

function schema = get_block_property(callbackInfo)
schema = sl_action_schema;
schema.label = 'block property';
schema.userdata = 'Hyo Custom';
schema.callback = @custom_callback;
end

function custom_callback(callbackInfo)
inspect(gcbh);
disp('### The property of current block is displayed.');
end