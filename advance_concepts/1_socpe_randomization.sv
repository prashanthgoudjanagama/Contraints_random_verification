


/*
_________________________________________________________________________________

 std::randomize() (static function):

            Used for randomizing non-class variables (like in a module or task).
            It does not depend on rand or constraint blocks.
            Constraints are provided inline with with { ... }.
------>
            bit [7:0] a, b;
            std::randomize(a, b) with { a < 100; b > 100; };

_________________________________________________________________________________

*/


module test();
    
  bit[7:0] a, b;

  initial begin
    std::randomize(a, b) with {a < 100; b > 100;};
        $display("a : %0d, b : %0d", a, b);

  end
  
endmodule : test