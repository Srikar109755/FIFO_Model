`timescale 1ns / 1ps

`define FWIDTH 32                                               //Width of the FIFO
`define FDEPTH 8                                                //Depth of the FIFO
`define FCWIDTH 32                                              //Counter Width of the FIFO 2^**

module FIFO_Model(
    Clk,
    RstN,
    Data_In,
    FClrN,
    FInN,
    FOutN,
    
    F_Data,
    F_FullN,
    F_EmptyN,
    F_LastN,
    F_SLastN,
    F_FirstN
    );
    
    input Clk;                                              // Clock Signal
    input RstN;                                             // Reset Signal
    input [(`FWIDTH-1) : 0]Data_In;                         // Data into FIFO
    input FClrN;                                            // Clear signal to FIFO
    input FInN;                                             // Write into FIFO
    input FOutN;                                            // Read from FIFO
    
    output [(`FWIDTH-1) : 0]F_Data;                         // Data out from FIFO
    output F_FullN;                                         // FIFO full indicating signal
    output F_EmptyN;                                        // FIFO empty indicating signal
    output F_LastN;                                         // FIFO Last but one signal
    output F_SLastN;                                        // FIFO FIFO SLast but one signal
    output F_FirstN;                                        // Only one element in FIFO
    
    reg F_FullN;
    reg F_EmptyN;
    reg F_LastN;
    reg F_SLastN;
    reg F_FirstN;
    
    reg [(`FCWIDTH-1) : 0]fcounter;                        // Indicating number elements in FIFO
    reg [(`FCWIDTH-1) : 0]wr_ptr;                          // Current Write pointer
    reg [(`FCWIDTH-1) : 0]rd_ptr;                          // Current Read pointer
    wire [(`FWIDTH-1) : 0]FIFODataOut;                     // Data out from FIFO Memblock
    wire [(`FWIDTH-1) : 0]FIFODataIn;                      // Data into FIFO Memblock
    
    wire ReadN = FOutN;
    wire WriteN = FInN;
    
    assign F_Data = FIFODataOut;
    assign FIFODataIn = Data_In;
    
    FIFO_MEM_BLK memblk(.clk(Clk),
                        .writeN(WriteN),
                        .rd_addr(rd_ptr),
                        .wr_addr(wr_ptr),
                        .data_in(FIFODataIn),
                        .data_out(FIFODataOut)                            
                        );
                        
    always@(posedge Clk or negedge RstN) begin
    
        if (!RstN) begin
            fcounter <= 0;
            rd_ptr <= 0;
            wr_ptr <= 0;
        end
        
        else begin
            if (!FClrN) begin
                fcounter <= 0;
                rd_ptr <= 0;
                wr_ptr <= 0;
            end
            
            else begin
                if (!WriteN && F_FullN)
                    wr_ptr <= wr_ptr + 1;
                
                if (!ReadN && F_EmptyN)
                    rd_ptr <= rd_ptr + 1;
                    
                if (!WriteN && ReadN && F_FullN)
                    fcounter <= fcounter + 1;
                    
                if (WriteN && !ReadN && F_EmptyN)
                    fcounter <= fcounter - 1;
            end    
        end
    end
    
    
    // EMPTY
    always@(posedge Clk or negedge RstN) begin
    
        if (!RstN)
            F_EmptyN <= 0;
            
        else begin
            if (FClrN == 1'b1) begin
                
                if (F_EmptyN == 1'b0 && WriteN == 1'b0)
                    F_EmptyN <= 1'b1;
                
                if (F_FirstN == 1'b0 && ReadN == 1'b0 && WriteN == 1'b1)
                    F_EmptyN <= 1'b0;
            end
            
            else 
                F_EmptyN <= 1'b0;
        end
    end
    
    // F_First indicates there is only one element in the FIFO
    always@(posedge Clk or negedge RstN) begin
        
        if (!RstN)
            F_FirstN <= 1'b1;
        
        else begin
            
            if (FClrN == 1'b1) begin
                if ((F_EmptyN == 1'b0 && WriteN == 1'b0) || (fcounter == 2 && ReadN == 1'b0 && WriteN == 1'b1))
                    F_FirstN <= 1'b0;
                
                if (F_FirstN == 1'b0 && (ReadN ^ WriteN))
                    F_FirstN <= 1'b1;
            end
            
            else begin
                F_FirstN <= 1'b1;
            end
        end
    end
    
    //FSLAST ONLY 2 SPACES FOR THE DATA
    always@(posedge Clk or negedge RstN) begin
        
        if(!RstN) 
            F_SLastN <= 1'b1;
            
        else begin
        
            if (FClrN == 1'b1) begin
                
                if ((F_LastN == 1'b0 && ReadN == 1'b0 && WriteN == 1'b1) || (fcounter == (`FDEPTH - 3 ) && ReadN == 1'b1 && WriteN == 1'b0))
                    F_SLastN <= 1'b0;
                    
                if (F_SLastN == 1'b0 && (ReadN ^ WriteN))
                    F_SLastN <= 1'b1;
            end
            
            else begin
                F_SLastN <= 1'b1;
            end
        end
    end
    
    //F_LastN indicates that there is only space for 1 data
    always@(posedge Clk or negedge RstN) begin
        
        if (!RstN)
            F_LastN <= 1'b1;
        else begin
            
            if (FClrN == 1'b1) begin
                
                if ((F_FullN == 1'b0 && ReadN == 1'b0 && WriteN == 1'b1) || (fcounter == (`FDEPTH - 2) && ReadN == 1'b1 && WriteN == 1'b0))
                    F_LastN <= 1'b0;
                
                if (F_LastN == 1'b0 && (ReadN ^ WriteN))
                    F_LastN <= 1'b1;
            end
            else begin
                F_LastN <= 1'b1;
            end
        end
    end
    
    //F_FullN indicate whether FIFO is empty or full)
    always@(posedge Clk or negedge RstN) begin
        
        if (!RstN)
            F_FullN <= 1'b1;
        else begin
            
            if (FClrN == 1'b1) begin
                
                if (F_LastN == 1'b0 && WriteN == 1'b0 && ReadN == 1'b1)
                    F_FullN <= 1'b0;
                
                if (F_FullN == 1'b0 && ReadN == 1'b0)
                    F_FullN <= 1'b1;
            end
            else begin
                F_FullN <= 1'b1;
            end
        end
    end

endmodule
