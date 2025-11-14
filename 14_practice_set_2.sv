

/*
_______________________________________________________________________
    --> Maths numbers using constraints
                Q1.     Assending order.
                Q2.     dessending order.
                Q3.     Even and odd b/w 0-100.
                Q4.     Even locations with odd numbers and odd Locations with even.
                Q5.     fibinacci num.
                Q6.     Unique num, with and without keyword.
                Q7.     factorial of a num.
                Q8.     palindrome of a num.
                Q9.     Armstrong num.
                Q10.    prime num.
_______________________________________________________________________
*/



// Q15.	Write a constraint to generate an array with unique values and multiples of 3 ?



// Q18.	Write a constraint to generate a variable with 0-31 bits as 1 and 32-61 bits as 0 ?
// Q19.	Write a constraint to generate consecutive and non-consecutive elements in a fixed-size array ?
// Q20. Write a constraint to randomly generate 10 unique numbers between 99 and 100 ?
// Q22.	Write a constraint to generate even numbers between 10 to 30 using a fixed-size array, dynamic array, and queue ?

// 24.	Write a constraint demonstrating the use of the "solve before" constraint ?
// 26.	Write a constraint for a 2D dynamic array to print consecutive elements ?
// 30.	Write a constraint so that the elements in two queues are different ?
// 31.	Write a constraint for a variable where the range 0-100 is 70% and 101-255 is 30% ?


/*
_______________________________________________________________________

			Q1. 	Assending order using constraint
_______________________________________________________________________

*/

class trans;
 
  rand bit[31:0] arr[];
  
  constraint arr_inside {
    arr.size inside {[10:15]};

    foreach(arr[i])
      arr[i] inside {[0:100]};
  } 
  
  constraint c_codn {
    foreach(arr[i])
      if(i>0)
        arr[i] > arr[i-1];
  }

  function void post_randomize();
    foreach(arr[i]) begin
    	$write("%0d	", arr[i]);
    end
  endfunction : post_randomize
  
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
  
endmodule : test


/*
_______________________________________________________________________

			Q2. 	dessending order using constraint
_______________________________________________________________________

*/

class trans;
 
  rand bit[31:0] arr[];
  
  constraint arr_inside {
    arr.size inside {[10:15]};

    foreach(arr[i])
      arr[i] inside {[0:100]};
  } 
  
  constraint c_codn {
    foreach(arr[i])
      if(i>0)
        arr[i] < arr[i-1];
  }

  function void post_randomize();
    foreach(arr[i]) begin
    	$write("%0d	", arr[i]);
    end
  endfunction : post_randomize
  
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
  
endmodule : test


/*
_______________________________________________________________________

			Q3. 	Even and odd numbes b/w 20-100
_______________________________________________________________________

*/

class trans;
 
  rand bit[31:0] arr[];
  
  constraint arr_inside {
    arr.size inside {[10:15]};

    foreach(arr[i])
      arr[i] inside {[20:100]};
  } 
  
  constraint c_codn {
    foreach(arr[i])
      // arr[i] % 2 == 0;  // even num
      arr[i] % 2 != 0;	   // odd num
  }

  function void post_randomize();
    foreach(arr[i]) begin
    	$write("%0d	", arr[i]);
    end
  endfunction : post_randomize
  
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
  
endmodule : test


/*
____________________________________________________________________

Q4. Even locations with odd and odd locations with Even numbers
____________________________________________________________________

*/

class trans;
 
  rand bit[31:0] arr[];
  
  constraint arr_inside {
    arr.size inside {[10:15]};

    foreach(arr[i])
      arr[i] inside {[20:100]};
  } 
  
  constraint c_codn {
    foreach(arr[i])
      if(i%2 == 0)
        arr[i] % 2 != 0;   // odd
      else
        arr[i] % 2 == 0;   // even
  }

  function void post_randomize();
    foreach(arr[i]) begin
    	$write("%0d	", arr[i]);
    end
  endfunction : post_randomize
  
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
  
endmodule : test


/*
___________________________________________________________________

			Q5. 	fibbinacci num
___________________________________________________________________

*/

class trans;
 
  rand bit[31:0] arr[];
  
  constraint arr_inside {
    arr.size == 10; 
  } 
  
  
 // function int fibi(int num);
 //   if(num <= 1)
 //     return num;
 //   else
 //     return fibi(num-1) + fibi(num-2);
 // endfunction : fibi 
  
  constraint c_codn {
    foreach(arr[i])
      if(i == 0)
        arr[i] == 0;   
      else if(i == 1)
        arr[i] == 1;  
      else 
        arr[i] == arr[i-1] + arr[i-2];
    
    // arr[i] == fibi(i);   //passing function inside the constraint

  }

  function void post_randomize();
    foreach(arr[i]) begin
    	$write("%0d	", arr[i]);
    end
  endfunction : post_randomize
  
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
  
endmodule : test


/*
___________________________________________________________________

			Q6. 	unique num | with or without keyword
___________________________________________________________________

*/

class trans;
 
  rand bit[31:0] arr[];
  
  constraint arr_inside {
    arr.size == 10; 
    
    foreach(arr[i])
      arr[i] inside {[20:100]};
  } 
  
//   constraint c_unique {
//     unique{arr};	        // direct method
//   }
  
  constraint c_codn {
    foreach(arr[i])
      foreach(arr[j])
      	if(i != j)
        	arr[i] != arr[j];
  }

  function void post_randomize();
    foreach(arr[i]) begin
    	$write("%0d	", arr[i]);
    end
  endfunction : post_randomize
  
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
  
endmodule : test

/*
___________________________________________________________________

	Q7. 	factorial of num | first 5- even and odd num
___________________________________________________________________

*/

class trans;
 
  rand bit[31:0] arr[];
  rand bit[31:0] arr_e[];
  rand bit[31:0] arr_o[];
  
  constraint arr_inside {
    arr.size == 10; 
    arr_e.size == 5; 
    arr_o.size == 5; 
  } 
  
  function int fact(int num);
    if(num <=1)
      return 1;
    else
      return num * fact(num-1);
  endfunction : fact
  
  constraint c_codn {
    // all 10 numbers fact
    foreach(arr[i])
      arr[i] == fact(i);
    
    foreach(arr_e[i]) {
        arr_e[i] == fact(i*2);      // first 5-even values
        arr_o[i] == fact((i*2)+1);  // first 5-odd values
    }

  }

  function void post_randomize();
    foreach(arr[i]) begin
    	$display("fact [%0d]	:   %0d", i, arr[i]);
    end
    	$display("__________________________");
    foreach(arr_e[i]) begin
    	$display("fact even [%0d]	:   %0d", i*2, arr_e[i]);
    end
    	$display("__________________________");
    foreach(arr_o[i]) begin
    	$display("fact odd [%0d]	:   %0d", (i*2)+1 , arr_o[i]);
    end
  endfunction : post_randomize
  
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    assert(tr.randomize());
  end
  
endmodule : test

/*
___________________________________________________________________

			Q8. 	palindrome of num -- 1221, 12321
___________________________________________________________________

*/

class trans;
 
  rand bit[31:0] num;

  constraint num_range {
      num inside {[120:135]};
  }

  constraint num_unique {
      unique{num};
  }


  function void post_randomize();
    int temp = num;
    int rev = 0;

    int palindrome;

    while(temp > 0) begin
        rev = (rev * 10) + (temp%10);
        temp = temp/10;
    end

    //if(rev == num) begin
    //    polindrome = rev;
    //    $display("[palindrome] : num is a palindrome : %0d", num);
   // end else begin
    //    $display("[not a palindrome] : num is not a palindrome : %0d", num);
    //end

    if(rev == num) begin
        palindrome = rev;
        $display("[palindrome] : num is a palindrome : %0d", palindrome);
    end

  endfunction : post_randomize
    
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    repeat(10)
        assert(tr.randomize());
  end
  
endmodule : test




/*
___________________________________________________________________

			Q9. Armstrong num --> 3**3 + 7**3 + 1**3 = 371
___________________________________________________________________

*/

class trans;
 
  rand bit[31:0] num;

  constraint num_range {
      num inside {[370:385]};
  }

  constraint num_unique {
      unique{num};
  }


  function void post_randomize();
    int temp = num;
    int sum = 0;
    int rem = 0;

    int armstrong;

    for(int i=0; i<3; i++) begin
        rem = temp % 10; 
        sum = (rem ** 3) + sum;
        temp = temp/10;
    end
    
   // if(sum == num) begin
   //     $display("[armstrong] : num is a Armstrong : %0d", armstrong);
  //  end else begin
  //      $display("[Not a armstrong] : num is a Armstrong : %0d", armstrong);
   // end

   
    if(sum == num) begin
        armstrong = sum;
        $display("[armstrong] : num is a Armstrong : %0d", armstrong);
    end

  endfunction : post_randomize
    
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    repeat(10)
        assert(tr.randomize());
  end
  
endmodule : test


/*
___________________________________________________________________

			Q10. prime num 
___________________________________________________________________

*/

class trans;
 
  rand bit[31:0] num;

  constraint num_range {
      num inside {[0:50]};
  }

  constraint num_unique {
      unique{num};
  }


  function void post_randomize();
    int temp = num;
    int is_prime = 1;

    int prime_num;

    if(num <= 1) begin
        is_prime = 0;
    end else begin
        for(int i = 2; i*i <= temp; i++) begin
            if(temp % i == 0) begin
                is_prime = 0;
            end
        end
    end

    if(is_prime) begin
        prime_num = num;
        $display("[prime num] : %0d", prime_num);
    end

  endfunction : post_randomize
    
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    repeat(15)
        assert(tr.randomize());
  end
  
endmodule : test
