%function climatewise_run
% climada climatewise
% MODULE:
%   storm europe
% NAME:
%   climatewise_run
% PURPOSE:
%   batch job to analise Climate Wise data - see climatewise_core for
%   the core batch job which is called by climatewise_run
%
%   Process the GBR_*.xlsx exposure data in one batch and the commercial
%   ones ??.xlsx in a second one (see exposure_files in PARAMETERS below)
%
%   for GBR_barclays_sector_agg.xlsx etc:
%   process_number_of_properties=1;
%   Percentage_Of_Value_Flag=1;
%
%   for ??.xlsx  etc:
%   process_number_of_properties=0;
%   Percentage_Of_Value_Flag=0;
%
%   Input are the bank's assets, stored in single Excel files with one
%   header row, followed by data (all numeric except for postcode_sector,
%   where AB10 1 is the entry, hence this space not to be confused with
%   space as a separator, as it might appear in the raw text here, but all
%   fine within Excel):
%       postcode_sector	latitude	longitude       number of properties    replacement_value_gbp
%       AB10 1          57.14687255	-2.106558026	17                      3447974
%       AB10 6          57.13707772	-2.122704986	106                     21499132
%       ...
%
%   Please note that for speedup, the hazard once loaded is kept, hence run
%   clear hazard in case you switch to another hazard set. Read the
%   PARAMETERS section carefully anyway (an expert code, not for beginners)
%   Please familiarize yurself with CLIMADA before running this code.
%
% CALLING SEQUENCE:
%   climatewise_run
% EXAMPLE:
%   climatewise_run
% INPUTS:
% OPTIONAL INPUT PARAMETERS:
% OUTPUTS:
%   to stdout and figures and to a folder ClimateWise within the CLIMADA
%   results folder
% MODIFICATION HISTORY:
% David N. Bresch, david.bresch@gmail.com, 20170803, initial, separated from climatewise_core
% David N. Bresch, david.bresch@gmail.com, 20170810, all automatic for WS and TC, today and climate change
%-

global climada_global
if ~climada_init_vars,return;end % init/import global variables

output_dir = "~/vivid/climatewise_climada/outputs";

plot_edfs = 0;
climada_global.DFC_return_periods = 1:200;

% PARAMETERS
%
% most parameters are set below, here only the general ones
%
% the reference return period we express the results for
reference_return_period=100;
%
Intensity_threshold_ms_WS=35; % intensity threshold for affected in m/s for WS
Intensity_threshold_ms_TC=55; % intensity threshold for affected in m/s for TC
Intensity_threshold_ms_TC=0.5; % TODO ask David; TEST intensity threshold for affected in m/s for TC

%
exposure_folder=[climada_global.data_dir filesep 'ClimateWise'];


climatewise_run_mortgage
    
#climatewise_run_commercial

    
