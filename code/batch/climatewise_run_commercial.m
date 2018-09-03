

% second commercial exposures (WS and TC)
% =======================================

exposure_files={
  %  '02.xlsx' % follow the global exposures
  %  '03.xlsx'
  %  '05.xlsx'
  %  '08.xlsx' % use this for tests
  %  '12.xlsx'
  %  '13.xlsx'
  %  '14.xlsx'
  %  '15.xlsx'
  %  '16.xlsx'
  %  '23.xlsx'
  %  '24.xlsx'
    '26.xlsx' % and this for tests, too
    };

process_number_of_properties=0;
Percentage_Of_Value_Flag=0;
plot_edfs = 0;

climate_scenario_times=[2015 2025 2035 2045 2055]; % reference 1960-1990


# Set up summary output file

summary_filename = [output_dir filesep 'commercial-summary.csv'];
fid = fopen(summary_filename,'w'); 
fprintf(fid,'portfolio,scenario,year,peril,ED_value,risk_today,value_column,currency_units,adaptation\n');
fclose(fid);


%%%% Cells for summary results
portfolio_column = {};
scenario_column = {};
peril_column = {};
year_column = {};
ED_value_column = {};
value_units_column = {};
currency_units_column = {};
risk_today_column = {};
value_column = {};
peril_column {};



% first for risk today
% --------------------
clear hazard % to be on the safe side
WS_hazard_CC_ext=''; % no climate change
TC_hazard_CC_ext=''; % no climate change
TS_hazard_CC_ext=''; % no climate change
adaptation = ''; % no adaptation
year = 1975; year
scenario_name = 'baseline'
fprintf('\n\n*** Risk today ***\n\n');


climatewise_core % call the core function
climatewise_write_eds_to_csv % write out ED curves to CSV and populate cells with summary results


% RCP45
% --------------------

wsgsmax_diff_file = [climada_global.data_dir filesep 'ClimateWise' filesep 'rcp45-wsgsmax-99pctl-diff.nc'];
scenario_name = 'rcp45';

for time_i=1:length(climate_scenario_times)
  clear hazard % to be on the safe side
  WS_hazard_CC_ext = sprintf('_rcp45_CC%4.4i',climate_scenario_times(time_i)); % make sure WS_time_i matches
  TC_hazard_CC_ext = sprintf('_rcp45_CC%4.4i',climate_scenario_times(time_i)); % make sure WS_time_i matches
  TS_hazard_CC_ext = sprintf('_rcp45_CC%4.4i_SLR',climate_scenario_times(time_i)); % make sure WS_time_i matches

  WS_time_i = time_i % Which time period to read from wsgsmax_diff_file
  year = climate_scenario_times(time_i);
  
  fprintf('\n\n*** Commercial RCP 4.5 ***\n\n');

  # Without adaptation 
  adaptation = '';
  climatewise_core % call the core function
  climatewise_write_eds_to_csv % write out ED curves to CSV and populate cells with summary results
  
  # With adaptation
  adaptation = '-adaptation';
  climatewise_core % call the core function
  climatewise_write_eds_to_csv % write out ED curves to CSV and populate cells with summary results

end



% RCP85
% --------------------

wsgsmax_diff_file = [climada_global.data_dir filesep 'ClimateWise' filesep 'rcp85-wsgsmax-99pctl-diff.nc'];
scenario_name = 'rcp85';

for time_i=1:length(climate_scenario_times)
  clear hazard % to be on the safe side
  WS_hazard_CC_ext = sprintf('_rcp45_CC%4.4i',climate_scenario_times(time_i)); % make sure WS_time_i matches
  TC_hazard_CC_ext = sprintf('_rcp45_CC%4.4i',climate_scenario_times(time_i)); % make sure WS_time_i matches
  TS_hazard_CC_ext = sprintf('_rcp85_CC%4.4i_SLR',climate_scenario_times(time_i)); % make sure WS_time_i matches

  
  WS_time_i = time_i % Which time period to read from wsgsmax_diff_file

  year = climate_scenario_times(time_i);
  
  fprintf('\n\n*** Commercial RCP 4.5 ***\n\n');

  # Without adaptation 
  adaptation = '';
  climatewise_core % call the core function
  climatewise_write_eds_to_csv % write out ED curves to CSV and populate cells with summary results
  
  # With adaptation
  adaptation = '-adaptation';
  climatewise_core % call the core function
  climatewise_write_eds_to_csv % write out ED curves to CSV and populate cells with summary results

end




#Write summary

fid = fopen(summary_filename,'a'); 
for i=1:length(portfolio_column)

  formatted_string = sprintf ("%s,%s,%s,%d,%d,%d,%s,%d,%s\n",
        portfolio_column{i}, scenario_column{i}, peril_column{i}, year_column{i}, ED_value_column{i},  risk_today_column{i} ,value_column{i},  currency_units_column{i}, adaptation_column{i});
  fprintf(fid, formatted_string);
end
fclose(fid);


% risk in GBP mio
% WS exposure today 	 climate 	 delta
%  02: 		 0.241 		 0.227 		 -5.6%
%  03: 		 1.907 		 2.035 		 6.7%
%  05: 		 0.191 		 0.186 		 -2.9%
%  08: 		 0.328 		 0.344 		 4.7%
%  12: 		 0.512 		 0.524 		 2.2%
%  13: 		 0.017 		 0.018 		 7.3%
%  15: 		 0.008 		 0.008 		 6.7%
%  16: 		 0.056 		 0.056 		 -0.3%
%  23: 		 0.090 		 0.096 		 6.4%
%  24: 		 0.000 		 0.000 		 5.9%
%  25: 		 0.536 		 0.588 		 9.8%
%  combined: 3.602 		 3.801 		 5.5%
%
% TC exposure today      climate     delta
%  08: 		 0.355 		 0.431 		 21.5%
%  12: 		 0.914 		 1.155 		 26.4%
%  14: 		 0.451 		 0.559 		 24.0%
%  15: 		 0.002 		 0.002 		 26.6%
%  25: 		 0.475 		 0.578 		 21.8%
%  combined: 1.566 		 1.890 		 20.7%

% % special check for negative delta climate WS result for 02
% % ---------------------------------------------------------
% entity=climada_entity_load('_ClimateWise_02');
% hazard_today=climada_hazard_load('WISC_FRA_eur_WS');
% hazard_climate=climada_hazard_load('WISC_FRA_eur_WS_CC2045');
% entity=climada_assets_encode(entity,hazard_today);
% 
% % via EDS_WS.ED_at_centroid asset 91 found with largest diff, via
% % entity.assets.centroid_index(91) centroid 34992 found
% % via EDS_WS.damage event 3227 found as max difference 
% hazard_today.intensity(3227,34992) % 43.9049
% hazard_climate.intensity(3227,34992) % 43.7067
% 
% % now to find the delta
% wsgsmax_diff_file = [climada_global.data_dir filesep 'ClimateWise' filesep 'wsgsmax_diff.nc'];
% wsgsmax_diff_var  = 'wsgsmax_delta_to_baseline';
% nc.time          = ncread(wsgsmax_diff_file,'time');
% nc.lon           = double(ncread(wsgsmax_diff_file,'lon'));
% nc.lat           = double(ncread(wsgsmax_diff_file,'lat'));
% nc.wsgsmax_delta = ncread(wsgsmax_diff_file,wsgsmax_diff_var);
% 
% wsgsmax_delta=griddata(nc.lon,nc.lat,nc.wsgsmax_delta(:,:,4),hazard.lon,hazard.lat,'nearest');
% size(wsgsmax_delta)
% wsgsmax_delta(34992) % -0.1983
% % --> that's exactly the intensity difference we found, all consistent
% 
% min(min(nc.wsgsmax_delta)) % -1.5184
% %  --> there are negative changes
% 
% min(min(wsgsmax_delta)) % -0.9295
% % --> the largest negative deviation at a centroids
% 
% climada_color_plot(wsgsmax_delta,hazard.lon,hazard.lat);hold on
% plot(entity.assets.lon(91),entity.assets.lat(91),'xr');
% text(entity.assets.lon(91)+0.2,entity.assets.lat(91),'-0.1983')