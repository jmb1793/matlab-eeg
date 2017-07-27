function signalWin = window_func(signal, window, overlap, hfunc, varargin)
% WINDOW_FUNC -> Do windowing in the signal

if nargin < 4, hfunc = @mean; end
if nargin < 5, varargin = {}; end

win_overlap = window-overlap;

% Filling all values
signalWin = [];
for k = 1:win_overlap:length(signal)
    last = k+win_overlap-1;
    
    if last+overlap > length(signal)
        intervM =  k:length(signal);
    else
        intervM = k:last+overlap;
    end
    
    signalWin(end+1) = hfunc( signal(intervM), varargin{:} );
end

end