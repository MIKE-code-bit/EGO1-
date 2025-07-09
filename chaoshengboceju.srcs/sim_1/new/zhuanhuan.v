`timescale 1ns / 1ps

module tb_bin_to_bcd;

    reg [16:0] binary_in;
    wire [15:0] ax, bx;

    bin_to_bcd_17bit uut (
        .binary_in(binary_in),
        .ax(ax),
        .bx(bx)
    );

    initial begin
        $display("Time\tBinary\t\tAX (BCD1)\tBX (BCD2-5)");
        $display("---------------------------------------------------------");

        binary_in = 17'd0;
        #10 $display("%0t\t%d\t%h\t\t%h", $time, binary_in, ax, bx);

        binary_in = 17'd5;
        #10 $display("%0t\t%d\t%h\t\t%h", $time, binary_in, ax, bx);

        binary_in = 17'd12;
        #10 $display("%0t\t%d\t%h\t\t%h", $time, binary_in, ax, bx);

        binary_in = 17'd123;
        #10 $display("%0t\t%d\t%h\t\t%h", $time, binary_in, ax, bx);

        binary_in = 17'd1234;
        #10 $display("%0t\t%d\t%h\t\t%h", $time, binary_in, ax, bx);

        binary_in = 17'd12345;
        #10 $display("%0t\t%d\t%h\t\t%h", $time, binary_in, ax, bx);

        binary_in = 17'd99999;
        #10 $display("%0t\t%d\t%h\t\t%h", $time, binary_in, ax, bx);

        $finish;
    end

endmodule
