function out = getDataObjectStatsString(obj)
% GETDATAOBJECTSTATSSTRING  Formats and returns stats string
%

out = '';
str = {};

tstep = obj.tsObj.TimeInfo.Increment;
if isnan(tstep)
  % Non-uniformally spaced
  tstep = obj.tsObj.Time(2) - obj.tsObj.Time(1);
end
if tstep < 1e-4
  % micro
  str{end+1} = sprintf('Time step \t: %.3f ms\n', tstep*1e3);
elseif tstep < 1e-1
  % ms
  str{end+1} = sprintf('Time step \t: %.1f ms\n', tstep*1e3);
else
  % s
  str{end+1} = sprintf('Time step \t: %.2f s\n', tstep);
end

str{end+1} = sprintf('\n');

str{end+1} = sprintf('Data (%s):\n', obj.tsObj.DataInfo.units);
str{end+1} = sprintf('\n');

stats = get(obj, 'Stats');
str{end+1} = sprintf([...
    '  Min. : %.2f\n', ...
    '  Median : %.2f\n', ...
    '  Max. : %.2f\n', ...
    '  Average : %.2f\n', ...
    '  St. dev. : %.2f\n', ...
    '  Skewness : %.2f\n', ...
    '  Kurtosis. : %.2f\n'], ...
                     stats.min,...
                     stats.median,...
                     stats.max,...
                     stats.mean,...
                     stats.stdev, ...
                     stats.skewness,...
                     stats.kurtosis);
                 
out = [str{:}];
