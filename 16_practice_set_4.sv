
/*
-------------------------------------------------------------------------------
Q4.Assume that you have two properties are rand bit[7:0]a and rand bit[2:0]b
      i). The range of values for b are 3,4,7
     ii). if b==3,the number of ones in the 'a' must be 4.
    iii). if b==4,the number of ones in the 'a' must be 5.
     iv). if b==7,the number of ones in the 'a' must be 8.
-------------------------------------------------------------------------------
*/
class trans;
  
  rand bit[7:0] a;
  rand bit[2:0] b;
  
  constraint b_range { 
    solve b before a;
    b inside {3,4,7};              // set-membership
    (b==3) -> $countones(a) == 4;  // using implication
    (b==4) -> $countones(a) == 5;
    if(b==7)                       // using if-else
      $countones(a) == 8;
  }
      
  function void post_randomize();
    $display("%d, %b", b, a);
  endfunction : post_randomize
    
endclass : trans

module tb();
  
  trans tr;
  
  initial begin
    tr = new();
    repeat(8)
    assert(tr.randomize());
  end
endmodule : tb

/*
---------------------------------------------------------------------------------------------
Q5.Write a constraint on a 16 bit rand vector to generate alternate pairs of 0's and 1's ?
Ex:0011.. or 1100..
---------------------------------------------------------------------------------------------
*/
class trans;
  
  rand bit[15:0] a;
  
  constraint a_alt { 
    foreach(a[i]) {
      if(i<15) {
        if(i%2==0)
          a[i+1] == a[i];
    	else
          a[i+1] != a[i];
      }
    }
  }
      
  function void post_randomize();
    $display("%b", a);
  endfunction : post_randomize
    
endclass : trans

module tb();
  
  trans tr;
  
  initial begin
    tr = new();
    repeat(8)
    	assert(tr.randomize());
  end
endmodule : tb

/*
-------------------------------------------------------------------------------
Q6.Write a constraint to randomly generate unique prime numbers in an
array between 1 and 200. The generated prime numbers should have 7 in
it ?
-------------------------------------------------------------------------------
*/

class trans;
  
  rand bit[7:0] a[];
  
  constraint a_size {
    a.size() inside {[1:200]};
  }
  
  extern function int prime(int num);
  
  extern constraint a_prime;
   

  function void post_randomize();
    int arr_7[$];

    foreach(a[i]) begin
      if(a[i] % 10 == 7)
        arr_7.push_back(a[i]);
    end
    
    $display("	%0p", a);
    $display("	%0p", arr_7);

  endfunction : post_randomize
    
endclass : trans
    
module tb();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
endmodule : tb
    
function int trans::prime(int num);
    bit is_prime = 1;
    if(num < 2) begin
      is_prime = 0;
    end else begin
      for(int i=2; i*i<=num; i++) begin
        if(num % i == 0) begin
          is_prime = 0;
        end 
      end
    end
    if(is_prime == 1)
      return num;
endfunction : prime
    
constraint trans::a_prime { 
    foreach(a[i])
      a[i]==prime(i);
  }
/*
-------------------------------------------------------------------------------
Q5.
-------------------------------------------------------------------------------
*/

/*
-------------------------------------------------------------------------------
Q5.
-------------------------------------------------------------------------------
*/

/*
-------------------------------------------------------------------------------
Q5.
-------------------------------------------------------------------------------
*/

/*
-------------------------------------------------------------------------------
Q5.
-------------------------------------------------------------------------------
*/

/*
-------------------------------------------------------------------------------
Q5.
-------------------------------------------------------------------------------
*/

/*
-------------------------------------------------------------------------------
Q5.
-------------------------------------------------------------------------------
*/

/*
-------------------------------------------------------------------------------
Q5.
-------------------------------------------------------------------------------
*/