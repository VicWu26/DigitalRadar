function [per_false_alarm, per_miss_detection, false_alarm] = dectection_analysis(range_probability, target)
    false_alarm = 0;
    per_false_alarm = range_probability;
    per_miss_detection = zeros(1, length(range_probability));
    for i = 1:size(target, 1)
        per_false_alarm(target(i, 1)+1) = 0;
        range_probability(target(i, 1)+1);
        per_miss_detection(target(i, 1)+1) = 1-range_probability(target(i, 1)+1); 
    end
end