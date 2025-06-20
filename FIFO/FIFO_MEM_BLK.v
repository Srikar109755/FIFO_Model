module FIFO_MEM_BLK(clk,
                    writeN,
                    wr_addr,
                    rd_addr,
                    data_in,
                    data_out
                   );
    input clk;
    input writeN;
    input [(`FCWIDTH-1) : 0] rd_addr;
    input [(`FCWIDTH-1) : 0] wr_addr;
    input [(`FCWIDTH-1) : 0] data_in;

    output [(`FWIDTH-1) : 0] data_out;
    
    reg [(`FWIDTH -1) : 0]FIFO[(`FDEPTH-1) : 0];
    
    always@(posedge clk) begin
        if (writeN == 1'b0)
            FIFO[wr_addr] <= data_in;
    end
    
    assign data_out = FIFO[rd_addr];

endmodule
