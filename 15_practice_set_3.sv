


/*
_____________________________________________________________________________________________
    --> matrix problems:

            Q1. declare a 2D array and print like a matrix and generate random even and odd values?
            Q2. generate a randmom even num in even positisions and odd num in a odd location
                matix 4x4?
            Q3. generate a identity matrix ?
            Q4. generate a upper and lower triangular matrix ?
            Q5. generate matrix of all left, right dagonal elements must be zero and other
                elements must be even num b/w 100-200?
            Q6. generate a matrix where sum of each row must be hundred?
            Q7. generate a matrix with alternative 1's and 0's?
            Q8. generate a matrix where border elements are 1 and remaining must be zero?
______________________________________________________________________________________________
*/
//  Q1. declare a 2D array and print like a matrix and generate random even and odd values?
//______________________________________________________________________________________________
class trans;
  
  rand bit[3:0] A [3][3];
  
  constraint A_S {
    foreach(A[i,j])
//         A[i][j] % 2 ==0;
        A[i][j] % 2 !=0;
  }
  
  
  function void post_randomize;
    foreach(A[i,j]) begin
      $write("%d\t\t", A[i][j]);
      if(j==2) 
        $display("\n");
    end
  endfunction : post_randomize
  
endclass : trans


module tb();
  
  trans t;
  
  initial begin
    t = new();
    assert(t.randomize());
  end
  
endmodule : tb
//______________________________________________________________________________________________
//  Q2. generate a randmom even num in even positisions and odd num in a odd location ?
class trans;
  
  rand bit[3:0] A [3][3];
  
  constraint A_S {
    foreach(A[i,j])
      if((i%2 == 0) && (j%2 == 0))
        A[i][j] % 2 ==0;
      else
        A[i][j] % 2 !=0;
  }
  
  
  function void post_randomize;
    foreach(A[i,j]) begin
      $write("%0d\t\t", A[i][j]);
      if(j==2) 
        $display("\n");
    end
  endfunction : post_randomize
  
endclass : trans


module tb();
  trans t;

  initial begin
    t = new();
    assert(t.randomize());
  end
  
endmodule : tb
//______________________________________________________________________________________________
// Q3. generate a identity matrix ?
class trans;
  
  rand bit[3:0] A [3][3];
  
  constraint A_S {
    foreach(A[i,j]) {
    //----- identity trianguler------
      if(i==j)
        A[i][j] == 1;
      else
        A[i][j] == 0;
    //----- upper trianguler------
    //   if(i>j)
    //     A[i][j] == 0;
    //   else
    //     A[i][j] % 5 == 0;
    //----- lower trianguler------
    //   if(i<j)
    //     A[i][j] == 0;
    //   else
    //     A[i][j] % 5 == 0;
    }
  }
  
  
  function void post_randomize;
    foreach(A[i,j]) begin
      $write("\t%d", A[i][j]);
      if(j==2) 
        $display("\n");
    end
  endfunction : post_randomize
  
endclass : trans


module tb();
  
  trans t;
  
  initial begin
    t = new();
    assert(t.randomize());
  end
  
endmodule : tb

//______________________________________________________________________________________________
// Q5. generate matrix of all left, right dagonal elements must be zero and other
//     elements must be even num b/w 100-200?
class trans;
  
  rand bit[7:0] A [3][3];
  
  constraint A_S {
    foreach(A[i,j]) {
      if(i==j)
        A[i][j] == 0;
      else if(i+j ==2)
        A[i][j] == 0;
      else
        A[i][j] inside {[100:200]};
    }
  }
  
  function void post_randomize;
    foreach(A[i,j]) begin
      $write("\t%d", A[i][j]);
      if(j==2) 
        $display("\n");
    end
  endfunction : post_randomize
  
endclass : trans


module tb();
  
  trans t;
  
  initial begin
    t = new();
    assert(t.randomize());
  end
  
endmodule : tb
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
//______________________________________________________________________________________________
