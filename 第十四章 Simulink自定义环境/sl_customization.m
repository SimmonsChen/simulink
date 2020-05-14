function sl_customization(cm)
%% Register custom menu function.
cm.addCustomMenuFcn('Simulink:ToolsMenu', @custom_items);
cm.addCustomMenuFcn('Simulink:ContextMenu', @custom_items);
cm.addCustomMenuFcn('LibraryBrowser:HelpMenu', @custom_items);
cm.LibraryBrowserCustomizer.applyOrder( {'Embedded Coder', -1.1} );
cm.addDlgPreOpenFcn('Simulink.ConfigSet',@ert_tlc_callback)
cm.addDlgPreOpenFcn('Simulink.SolverCC',@disable_solver_type);
cm.registerTargetInfo(@loc_register_device);

end

%% Define the custom menu function.
function schemaFcns = custom_items(callbackInfo)
schemaFcns = {@menu_control};
end

function disable_solver_type(dialogH)
dialogH.hideWidgets({'Simulink.SolverCC.SolverType'});
dialogH.disableWidgets({'Simulink.SolverCC.StartTime'});
dialogH.disableWidgets({'Simulink.RTWCC.Build'});
end

function ert_tlc_callback(dialogH)
systargetfile = dialogH.getSource.get_param('SystemTargetFile');
if strcmp(systargetfile, 'ert.tlc')
    dialogH.getSource.set_param('GenerateReport', 'on')
    dialogH.disableWidgets({'Simulink.RTWCC.GenerateReport'});
end
end
% loc_register_devie resigters self defined device into Simulink Parameter
% cofiguration
function thisprod = loc_register_device
  thisprod = RTW.HWDeviceRegistry;
  thisprod.Vendor = 'Hyo Ltd.';
  thisprod.Type = 'Simulink Type';
  thisprod.Alias = {};
  thisprod.Platform = {'Prod','Test'};
  thisprod.setWordSizes([8 16 16 32 32]);
  thisprod.LargestAtomicInteger = 'Char';
  thisprod.LargestAtomicFloat = 'Float';
  thisprod.Endianess = 'Big';
  thisprod.IntDivRoundTo = 'floor';
  thisprod.ShiftRightIntArith = true;
  thisprod.setEnabled({'BitPerPointer'});
end


