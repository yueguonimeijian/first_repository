module top_hdmi(
input   wire            sys_clk,
input   wire            sys_rst_n,

output  wire            hsync,
output  wire            vsync,
output  wire    [15:0]  vga_rgb
);

wire        vga_clk;
wire        locked;
wire        rst_n;

wire    [9:0]   pix_x;
wire    [9:0]   pix_y;
wire    [15:0]  pix_data;

assign  rst_n=(sys_rst_n && locked);




color_bar color_bar(
    .vga_clk(vga_clk),
    .sys_rst_n(rst_n),
    .pix_x(pix_x),
    .pix_y(pix_y),

    .pix_data(pix_data)
);



clk_vga clk_vga(
    .clk_out1(vga_clk),  
    .reset(~sys_rst_n), 
    .locked(locked),     
    .clk_in1(sys_clk));  

ctrl_hdmi ctrl_hdmi(
    .vga_clk(vga_clk),
    .sys_rst_n(rst_n),
    .pix_data(pix_data),

    .hsync(hsync),
    .vsync(vsync),
    .pix_x(pix_x),
    .pix_y(pix_y),
    .rgb_data(vga_rgb)
);




endmodule