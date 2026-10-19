
function [z, I, data] = readNECcurrent(filename, lambda)
% READNECCURRENT Extract segment currents from a NEC2 output file.
%
% INPUT:
%   filename : path to the NEC output file
%   lambda   : wavelength in meters (optional)
%
% OUTPUT:
%   z        : segment-center axial coordinates
%   I        : complex segment currents [A]
%   data     : table containing all extracted quantities
%
% Coordinates in the supplied NEC file are in wavelengths.
% If lambda is supplied, z is returned in meters.

if nargin < 2
    lambda = 1;
end

txt = fileread(filename);

% Locate the current table.
header = regexp(txt, 'CURRENTS AND LOCATION', ...
    'once', 'ignorecase');

if isempty(header)
    error('Current table not found in NEC output.');
end

txt = txt(header:end);
lines = regexp(txt, '\r\n|\n|\r', 'split');

% Columns:
% SEG TAG X Y Z LENGTH REAL IMAG MAG PHASE
fmt = ['%f %f %f %f %f %f ' ...
    '%f %f %f %f'];

rows = zeros(0,10);
started = false;

for k = 1:numel(lines)

    line = strtrim(lines{k});
    values = sscanf(line, fmt);

    if numel(values) == 10
        rows(end+1,:) = values(:).'; %#ok<AGROW>
        started = true;
    elseif started
        break
    end

end

if isempty(rows)
    error('No segment-current data found.');
end

z = rows(:,5) * lambda;

I = complex(rows(:,7), rows(:,8));

data = array2table(rows, 'VariableNames', ...
    {'Segment','Tag','X','Y','Z','Length', ...
    'Real','Imag','Magnitude','Phase'});

% Convert coordinate columns to meters.
data.X = data.X * lambda;
data.Y = data.Y * lambda;
data.Z = data.Z * lambda;
data.Length = data.Length * lambda;

end