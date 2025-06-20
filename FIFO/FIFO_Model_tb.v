`timescale 1ns / 1ps

`define FWIDTH 32
`define FCWIDTH 3
`define FDEPTH 8

module FIFO_Model_tb();
    reg Clk;
    reg RstN;
    reg FClrN;
    reg FInN;
    reg FOutN;
    reg [(`FWIDTH-1) : 0] Data_In;
    
    wire F_FullN;
    wire F_LastN;
    wire F_SLastN;
    wire F_FirstN;
    wire F_EmptyN;
    wire [(`FWIDTH-1) : 0] F_Data;
    
    FIFO_Model DUT (
        .Clk(Clk),
        .RstN(RstN),
        .Data_In(Data_In),
        .FClrN(FClrN),
        .FInN(FInN),
        .FOutN(FOutN),
        
        .F_Data(F_Data),
        .F_FullN(F_FullN),
        .F_EmptyN(F_EmptyN),
        .F_LastN(F_LastN),
        .F_SLastN(F_SLastN),
        .F_FirstN(F_FirstN)
    );
    
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end
    
    initial begin
        RstN = 0;
        FClrN = 1;
        FInN = 1;                                               // NO WRIRE
        FOutN = 1;                                              // NO READ
        Data_In = 0;
        
        // Reset Applied
        #20 RstN = 1;
        
        // Test Clear
        #10 FClrN = 0;
        #10 FClrN = 1;
        
        // Writing into FIFO
        $display("Writing Data into FIFO");
        repeat(`FDEPTH) begin
            @(posedge Clk)
            Data_In = $random;
            FInN = 0;                                           // WRITE ENABLE ACTIVE
            FOutN = 1;
            
            @(posedge Clk)
            FInN = 1;                                           // DISABLE WRITE
        end
        
        // FIFO Full Condition
        @(posedge Clk)
        $display("FIFO - FULL");
        
        @(posedge Clk) 
        Data_In = 32'hCDABEFDC;                                 // Trying to Write when FIFO is FULL
        FInN = 0;
        @(posedge Clk)
        FInN = 1;
        
        
        // Read Operation to empty the FIFO
        $display("Reading from FIFO");
        repeat(`FDEPTH) begin
            @(posedge Clk)
            FOutN = 0;
            FInN = 1;
            @(posedge Clk)
            FOutN = 1;
        end
        
        // FIFO Empty Condition
        @(posedge Clk)
        $display("FIFO - EMPTY");
        
        @(posedge Clk)
        FOutN = 0;                                              // Trying to Read when FIFO is EMPTY
        @(posedge Clk)
        FOutN = 1;
        
        
        // Writing one element Check the First Flag
        @(posedge Clk)
        $display("Test F_FirstN Condition");
        Data_In = 32'h98765432;
        FInN = 0;
        FOutN = 1;
        @(posedge Clk)
        FInN = 1;
        
        // Reading that one element
        @(posedge Clk)
        FOutN = 0;
        FInN = 1;
        @(posedge Clk)
        FOutN = 1;
        
        // To Test Flags F_SLatN and F_LastN
        $display("Test F_SLastN | F_LastN");
        repeat (`FDEPTH - 1) begin
            @(posedge Clk)
            Data_In = $random;
            FInN = 0;
            FOutN = 1;
            @(posedge Clk)
            FInN = 1;
        end
        
        // Filling remaing one element to check full condition again
        @(posedge Clk)
        Data_In = 32'h12345678;
        FInN = 0;
        FOutN = 1;
        @(posedge Clk)
        FInN = 1;
        
        // Reading all the elements from the FIFO
        repeat(`FDEPTH) begin
            @(posedge Clk)
            FOutN = 0;
            @(posedge Clk)
            FOutN = 1;
        end
        
        $display("TEST Finished");
        #100 $finish;
    end
    
endmodule
