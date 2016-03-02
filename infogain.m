% Information Gain Calculator
% Jeffrey Jedele, 2011

function [max_gain_feature, gain] = infogain(Data,Idx,topX)
%     max_gain_feature = 0;
    x = Data;
    y = Idx;
    info_gains = zeros(1, size(x,2));

    % calculate H(y)
    classes = unique(y);
    hy = 0;
    for c=classes'
        py = sum(y==c)/size(y,1);
        hy = hy + py*log2(py);
    end;
    hy = -hy;

    % iterate over all features (columns)
    for col=1:size(x,2)
        
        features = unique(x(:,col));

        % calculate entropy
        hyx = 0;
        for f=features'
            
            pf = sum(x(:,col)==f)/size(x,1);
            yf = y(find(x(:,col)==f));
            
            % calculate h for classes given feature f
            yclasses = unique(yf);
            hyf = 0;
            for yc=yclasses'
                pyf = sum(yf==yc)/size(yf,1);
                hyf = hyf + pyf*log2(pyf);
            end;
            hyf = -hyf;
            hyx = hyx + pf * hyf;
        end;
        info_gains(col) = hy - hyx;

    end;

    gain = zeros(1,topX);
    max_gain_feature = zeros(1,topX);
    for i = 1:topX
        [gain(i), max_gain_feature(i)] = max(info_gains);
        info_gains(max_gain_feature(i)) = -1;
    end;
end