csvnames = dir("*.csv");
outfile = fopen('results.txt', 'w');
for i=1:size(csvnames, 1)
    [pks, ~, widths] = getpeaks(csvnames(i).name);
    [~, traceName, ~] = fileparts(csvnames(i).name);
    fprintf(outfile, '%s:\n', traceName);
    fprintf(outfile, '%6.2f, %6.2f\n', [pks'; widths']);
    fprintf(outfile, '\n');
end
fclose(outfile);
function [pks, locs, w] = getpeaks(filename)
trace=csvread(filename, 1, 0);
thresh = (max(trace(:,2))-min(trace(:,2)))/5;
figure, findpeaks(trace(:,2), trace(:,1), 'MinPeakProminence', thresh, ...
    'Annotate', 'extent','MinPeakHeight',1250)
[~, traceName, ~] = fileparts(filename);
title(traceName)
%savefig(gcf, traceName, 'compact')
saveas(gcf, [traceName, '.png']);
[pks, locs, w] = findpeaks(trace(:,2), trace(:,1), 'MinPeakProminence', thresh);
end
