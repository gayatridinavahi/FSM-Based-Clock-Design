module hw21 (clk, rst, leap, mon, day, hrs, min, sec);
input clk, rst, leap;
output reg [3:0] mon;
output reg [4:0] day;
output reg [4:0] hrs;
output reg [5:0] min;
output reg [5:0] sec;

parameter SIZE_MONTH=4;
parameter SIZE_D=5;
parameter SIZE_H=5;
parameter SIZE_M=6;
parameter SIZE_S=6;

parameter ZERO=0;
parameter ONE=1;

parameter [SIZE_MONTH-1:0] FEB = 2;
parameter [SIZE_D-1:0] DD_MAX=31; 
parameter [SIZE_D-1:0] DD_MIN=28; 
parameter [SIZE_M-1:0] FN=59;
parameter [SIZE_H-1:0] TT=23;

reg [SIZE_D-1:0] DD; 

always @*
begin
    case (mon)
        1, 3, 5, 7, 8, 10, 12: DD = DD_MAX; 
        4, 6, 9, 11: DD = 30; 
        FEB: DD = leap ? 29 : DD_MIN; 
        default: DD = DD_MIN; 
    endcase
end

always @(posedge clk or posedge rst) begin
    if(rst) sec <= ZERO;
    else sec <= sec == FN ? ZERO : sec + ONE;
end

always @(posedge clk or posedge rst) begin
    if (rst) min <= ZERO;
    else if (sec == FN) min <= min == FN ? ZERO : min + ONE;
end

always @(posedge clk or posedge rst) begin
    if (rst) hrs <= ZERO;
    else if ({sec,min} == {FN,FN}) hrs <= hrs == TT ? ZERO : hrs + ONE;
end

always @(posedge clk or posedge rst) begin
    if (rst) day <= ONE;
    else if ({sec,min,hrs} == {FN,FN,TT}) day <= day == DD ? ONE : day + ONE;
end

always @(posedge clk or posedge rst) begin
    if (rst) mon <= ONE;
    else if ({sec,min,hrs,day} == {FN,FN,TT,DD}) mon <= mon == 12 ? ONE : mon + ONE;
end

endmodule
