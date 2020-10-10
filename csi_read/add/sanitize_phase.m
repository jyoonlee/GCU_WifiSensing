% Phase Transformation
function output_phase=sanitize_phase(input_phase)

x = unwrap(input_phase);
a = ( x(30) - x(1) )/ 30;
b = sum(x)/30;
range = [-15:-1 , 1:15];
output_phase = x - (a*range + b*ones(1,30));