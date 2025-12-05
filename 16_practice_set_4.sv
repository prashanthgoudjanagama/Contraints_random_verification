
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
Q7. Write a constraint to generate 32 bit number with 1 bit high?
-------------------------------------------------------------------------------
*/
class trans;
  
  rand bit[31:0] data;
  
  constraint a_onehot {
    $onehot(data);
  }
  
  function void post_randomize();
    $display("%b", data);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
endmodule : tb
/*
-------------------------------------------------------------------------------
Q8. Write a constraint for 16-bit variable such that no two
consecutive ones should be generated ?
-------------------------------------------------------------------------------
*/
class trans;
  
  rand bit[31:0] data;
  
  constraint a_onehot {
    foreach(data[i])
      if(i>0 && data[i] == 1)
        data[i] != data[i-1]; 
  }
  
  function void post_randomize();
    $display("%b", data);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
endmodule : tb
/*
-------------------------------------------------------------------------------
Q9. Constraint for 0-100 range is 70% and 101-255 range is 30%?
-------------------------------------------------------------------------------
*/
class trans;
  
  rand bit[7:0] data[];
  
  constraint data_size {
    data.size() == 10;
  }
  
  // [0-100] : = 70% && [101:255] :=30%
  constraint data_cond {
    foreach(data[i])
      data[i] dist {[0:100]:=7, [101:255]:=3};
  }
  
  function void post_randomize();
    foreach(data[i])
      $write("%0d ", data[i]);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
endmodule : tb
/*
-------------------------------------------------------------------------------
Q10. Write a constraint so that if we randomize a single bit variable
for 10 times values should generate be like 101010101010?
-------------------------------------------------------------------------------
*/

class trans;
  
  rand bit a;
  bit b=1;
  
  constraint a_cond {
    (a != b);
  }
  
  function void post_randomize();
    $write("%b%b",a,b);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    repeat(10)
   	 assert(tr.randomize());
  end
endmodule : tb
/*
-------------------------------------------------------------------------------
Q11. Write a constraint to generate even numbers should in the range of
10 to 30 using Fixed size array, Dynamic array & Queue?
-------------------------------------------------------------------------------
*/
class trans;
  
  rand bit [7:0] a[10];
  rand bit [7:0] b[];
  rand bit [7:0] c[$];
  
  constraint a_size {
    b.size() inside {[10:20]};
    c.size() inside {[10:20]};
  }
  
  constraint a_cond {
    foreach(a[i]) 
      a[i] % 2 == 0;
    foreach(b[i]) 
      b[i] % 2 == 0;
    foreach(c[i]) 
      c[i] % 2 == 0;

  }
  
  function void post_randomize();
    $display("%0p",a);
    $display("%0p",b);
    $display("%0p",c);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
   	 assert(tr.randomize());
  end
endmodule : tb
/*
-------------------------------------------------------------------------------
Q12. write a constraint to randmoly genrate 10 unquie numbers between 99 to 100 ?
-------------------------------------------------------------------------------
*/
class trans;
  
  rand int a[10];
  real b[10];
  
  constraint a_range {
    foreach(a[i])
      a[i] inside {[990:1000]};
  }
  constraint a_cond {
    foreach(a[i]) 
      foreach(a[j])
        if(i!=j)
          a[i] != a[j];
  }
  
  function void post_randomize();
    foreach(b[i])
      b[i] = (a[i]/10.0);
   
    $display("%0p",a);
    $display("%0p",b);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
   	 assert(tr.randomize());
  end
endmodule : tb
/*
-------------------------------------------------------------------------------
Q13. Write a constraint to generate consecutive elements using Fixed
     size array and also write the constraint to generate non consecutive
     elements?
-------------------------------------------------------------------------------
*/

class trans;
  
  rand int a[10];
  
  constraint a_range {
    foreach(a[i])
      a[i] inside {[0:100]};
  }
  
  // consequetive
  constraint a_con {
    foreach(a[i])
      a[i] == i;
  }
  
  // non-consequetive
  constraint a_cond {
    foreach(a[i]) 
      foreach(a[j])
        if(i!=j)
          a[i] != a[j];
  }
  
  function void post_randomize();
    $display("%0p",a);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
   	 assert(tr.randomize());
  end
endmodule : tb

/*
-------------------------------------------------------------------------------
Q14. Write a constraint to generate a variable with 0-31 bits should be
     1, 32-61 bits should be 0?
-------------------------------------------------------------------------------
*/
class trans;
  
  rand bit[63:0] data;
  
  constraint a_con {
    foreach(data[i])
      if(i<32)
        data[i] == 0;
      else
        data[i] == 1;
  }
  
  function void post_randomize();
    $display("%h	",data);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    repeat(10)
   	 assert(tr.randomize());
  end
endmodule : tb
/*
-------------------------------------------------------------------------------
Q15. Write a constraint to generate a 32 bit variable lower byte must be 8 and
     remaining bits should be random? 
-------------------------------------------------------------------------------
*/
class trans;
  
  rand bit[31:0] data;
  
  constraint a_con {
    // data % 256 == 8;
    data[7:0] == 8;
  }
  
  function void post_randomize();
    $display("%h	",data);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    repeat(10)
   	 assert(tr.randomize());
  end
endmodule : tb

/*
-------------------------------------------------------------------------------
Q16. Write a constraint on two dimensional array for generating even
     numbers in the first 4 locations and odd numbers in the next 4
     locations.Also the even number should be in multiple of 4 and odd number
     should be multiple of 3 ?
-------------------------------------------------------------------------------
*/


/*
-------------------------------------------------------------------------------
Q17. write a constraint for a 32bit variable
      i). only 12th bit should be random?
      ii). it conntains 12 no of 1's but all are not consecutive?
      iii). it contains 12 no of 1's but 4 1's are consecutive?
-------------------------------------------------------------------------------
*/
// i)____________________________________________________________________
class trans;
  
  rand bit[31:0] data;
  
  constraint a_con {
    foreach(data[i])
      if(i==11)
        data[i] inside {0,1};
      else
        data[i] == 0;
  }
  
  function void post_randomize();
    $display("%h	",data);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    repeat(10)
   	 assert(tr.randomize());
  end
endmodule : tb

// ii)____________________________________________________________________
class trans;
  
  rand bit[31:0] data;
  
  constraint a_ones {
    $countbits(data, 1) == 12;
  }
  
  constraint a_con {
    foreach(data[i])
      if(i>0 && data[i] == 1)
        data[i] != data[i-1];
  }
  
  function void post_randomize();
    $display("%b	",data);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
    repeat(10)
   	 assert(tr.randomize());
  end
endmodule : tb

// iii). it contains 12 no of 1's but no 4 1's are consecutive?
//__________________________________________________________________


class trans;
  
  rand bit[31:0] a;
  
  constraint a_a {
    $countbits(a,1) == 12;
    foreach (a[i]) {
      if (i <= 28)   
        !(a[i] && a[i+1] && a[i+2] && a[i+3]);
    }
  }
  
  function void post_randomize();
    $display("%b ",a);
  endfunction: post_randomize
  
endclass : trans

module tb();
  trans tr;
  
  initial begin
    tr = new();
   	 assert(tr.randomize());
  end
endmodule : tb


