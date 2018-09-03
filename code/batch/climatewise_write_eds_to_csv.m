
if exist('EDS_WS','var')


  for EDS_i=1:length(EDS_WS)

    DFC=climada_EDS2DFC(EDS_WS(EDS_i), 1:200); % calculate all damage excedance frequency curves
    reference_pos = DFC(1).return_period==reference_return_period;

    for DFC_i=1:length(DFC)
        portfolio_column = [portfolio_column ; DFC(DFC_i).annotation_name];
        scenario_column = [scenario_column ; scenario_name];
        year_column = [year_column ; year];
        ED_value_column = [ ED_value_column ; DFC(DFC_i).ED];
        risk_today_column = [ risk_today_column ; DFC(DFC_i).damage(reference_pos) ];
        value_column = [value_column ; DFC(DFC_i).Value_unit ] ;
        currency_units_column =  [currency_units_column ; DFC(DFC_i).currency_unit ] ;
        adaptation_column = [ adaptation_column ; adaptation ] ;
        peril_column = [ peril_column ; 'WS' ];
       

        output_filename = [output_dir filesep DFC(DFC_i).annotation_name '-WS-' scenario_name '-' sprintf("%d", year) adaptation '.csv']
        fid = fopen(output_filename,'w'); 
        fprintf(fid,'return_period,damage\n');
        fclose(fid);
        dlmwrite(output_filename,[ DFC(1).return_period ; DFC(1).damage ]','-append');

    end
  end

end % WS


if exist('EDS_TC','var')
    
    DFC=climada_EDS2DFC(EDS_TC, 1:200); % calculate all damage excedance frequency curves
    reference_pos = DFC(1).return_period==reference_return_period;

    for DFC_i=1:length(DFC)
      portfolio_column = [portfolio_column ; DFC(DFC_i).annotation_name];
      scenario_column = [scenario_column ; scenario_name];
      year_column = [year_column ; year];
      ED_value_column = [ ED_value_column ; DFC(DFC_i).ED];
      risk_today_column = [ risk_today_column ; DFC(DFC_i).damage(reference_pos) ];
      value_column = [value_column ; DFC(DFC_i).Value_unit ] ;
      currency_units_column =  [currency_units_column ; DFC(DFC_i).currency_unit ] ;
      adaptation_column = [ adaptation_column ; adaptation ] ;
      peril_column = [ peril_column ; 'TC' ];
       

 
 
      output_filename = [output_dir filesep DFC(DFC_i).annotation_name '-TC-' scenario_name '-' sprintf("%d", year) adaptation '.csv']
      fid = fopen(output_filename,'w'); 
      fprintf(fid,'return_period,damage\n');
      fclose(fid);
      dlmwrite(output_filename,[ DFC(1).return_period ; DFC(1).damage ]','-append');

    end
    
end % TC





if exist('EDS_TS','var')
    
    DFC=climada_EDS2DFC(EDS_TS, 1:200); % calculate all damage excedance frequency curves
    reference_pos = DFC(1).return_period==reference_return_period;

    for DFC_i=1:length(DFC)
      portfolio_column = [portfolio_column ; DFC(DFC_i).annotation_name];
      scenario_column = [scenario_column ; scenario_name];
      year_column = [year_column ; year];
      ED_value_column = [ ED_value_column ; DFC(DFC_i).ED];
      risk_today_column = [ risk_today_column ; DFC(DFC_i).damage(reference_pos) ];
      value_column = [value_column ; DFC(DFC_i).Value_unit ] ;
      currency_units_column =  [currency_units_column ; DFC(DFC_i).currency_unit ] ;
      adaptation_column = [ adaptation_column ; adaptation ] ;
      peril_column = [ peril_column ; 'TS' ]; 
 
      output_filename = [output_dir filesep DFC(DFC_i).annotation_name '-TS-' scenario_name '-' sprintf("%d", year) adaptation '.csv']
      fid = fopen(output_filename,'w'); 
      fprintf(fid,'return_period,damage\n');
      fclose(fid);
      dlmwrite(output_filename,[ DFC(1).return_period ; DFC(1).damage ]','-append');

    end
    
end % TS