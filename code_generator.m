function [code_list] = code_generator(code_length, subarray_element, subarray_num)
    code_list_beam = [];
    code_list = [];
    
    % generate random binary sequence
   for i = 1:subarray_num
       code = randi([0,1], 1, code_length);
       code_list = [code_list;code];
   end

   %{
   for i = 1:subarray_num
       code = code_list(i,:);
       for j = 1:(subarray_element)
           code_list_beam = [code_list_beam;code];
       end
   end
   %}
    
    %{
    [Ga, Gb] = wlanGolaySequence(32);
    Ga = transpose(Ga);
    Gb = transpose(Gb);
    Ga(Ga == -1) = 0;
    Gb(Gb == -1) = 0;
    code_list = [code_list;Ga];
    
    code = zeros(1, 32);
    for j = 1:length(Ga)-1
        code(j) = (2*Ga(j)-1)*(2*Gb(j+1)-1);
    end
    code(32) = (2*Ga(32)-1)*(2*Gb(1)-1);
    code(code == -1) = 0;
    
    code = [1 1 0 1 1 1 0 1 0 1 1 1 0 1 1 1 1 0 1 1 1 0 1 1 0 0 0 1 0 0 0 1];
    code_list = [code_list;code];
    %}
end