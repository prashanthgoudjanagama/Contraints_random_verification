
class trans;
 
  randc bit[31:0] num;

  constraint num_range {
      num inside {[0:50]};
  }

//  constraint num_unique {
  //    unique{num};
  // }


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
        $write("%0d   ", prime_num);
    end


  endfunction : post_randomize
    
endclass : trans


module test();
  
  trans tr;
  
  initial begin
    tr = new();
    repeat(50)
        assert(tr.randomize());
  end
  
endmodule : test
