function listblock_callback(action)
switch action
    case 'g_list'
        block_h = find_system(gcs, 'findall', 'on','Type', 'block');
        len = length(block_h);
        block_name = get_param(block_h(1), 'Name');
        for ii = 2:len
           block_name = [block_name, '|', get_param(block_h(ii), 'Name')];
        end
        mask_styles = get_param(gcbh, 'MaskStyles');
        mask_styles{2} = ['radiobutton(' ,block_name, ')'];
        set_param(gcbh, 'MaskStyles', mask_styles);
    case 'g_enable'
        val = get_param(gcbh, 'g_enable');
        if strcmp(val, 'on')
            mask_visibility = {'on','on'};
        else
            mask_visibility = {'on','off'};
        end
        set_param(gcbh, 'maskvisibilities', mask_visibility);
    otherwise
        errordlg('Not defined operation!');
end
