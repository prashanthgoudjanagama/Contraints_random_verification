




// Code your testbench here
// or browse Examples




class trans;
  
  rand bit arr[5];
  
  constraint arr_c {
    unique{arr};
    arr.sum() with (int'(item)) == 12;
    arr.product() with (int'(item)) == 12;
    arr.and() with (int'(item)) == 1;
    arr.xor() with (int'(item)) == 1;
    arr.or() with (int'(item)) == 0;


         
  }
  
  
  function void post_randomize();
    $display("array : %0p : or = %0d", arr, arr.or());
  endfunction : post_randomize
  
endclass : trans

module test();
  trans t;
  
  initial begin
    t = new();
    t.randomize();
  end
  
endmodule : test