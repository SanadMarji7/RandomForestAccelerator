--this design implements and generates the Random Forest on hardware.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

--entity of design has: 
--4 inputs (sepal_length, sepal_width, petal_length, petal_width) each 4 bits which are the features of the iris data-set
--1 output: class_out can have 3 possible outputs only "0000"=>(setosa), "0001"=>(versicolor), "0010"=>(virginica)
entity Random_Forest_accelerator is
    port(
        sepal_length : in std_logic_vector(3 downto 0);
        sepal_width : in std_logic_vector(3 downto 0); 
        petal_length : in std_logic_vector(3 downto 0);
        petal_width : in std_logic_vector(3 downto 0); 
        class_out : out std_logic_vector(3 downto 0)
     );
  
end Random_Forest_accelerator;

architecture Behavioral of Random_Forest_accelerator is

-- array results below stores the class from each of the 10 decision trees which will then be 
--used in the majority vote component to calculate the final decision.
   type mem is array(0 to 9) of std_logic_vector(3 downto 0);
   signal results : mem;
   signal finalresult : std_logic_vector(3 downto 0); --signal for the final decision of the design
   signal en : std_logic; --enable bit used in the majority vote component
   
   component majorityVote
       port(
            enable : in std_logic;
            a,b,c,d,e,f,g,h,i,j : in std_logic_vector(3 downto 0);
            class : out std_logic_vector(3 downto 0)
       );
   end component;
   component DT
       port(
        tree_number : in integer;
        sepal_length : in std_logic_vector(3 downto 0);
        sepal_width : in std_logic_vector(3 downto 0); 
        petal_length : in std_logic_vector(3 downto 0); 
        petal_width : in std_logic_vector(3 downto 0);
        class_out : out std_logic_vector(3 downto 0)
        );
    end component;     
          
begin
--10 instances of the DT component are called, each given a unique tree_number and the same sl, sw, pl, pw values to calculate their decisions simultaniously
--the calculated decision is then stored in results(tree_number) which will then be used in the majority_vote component.
    instance_DT0 : DT port map(tree_number => 0, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(0));
    instance_DT1 : DT port map(tree_number => 1, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(1));
    instance_DT2 : DT port map(tree_number => 2, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(2));
    instance_DT3 : DT port map(tree_number => 3, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(3));
    instance_DT4 : DT port map(tree_number => 4, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(4));
    instance_DT5 : DT port map(tree_number => 5, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(5));
    instance_DT6 : DT port map(tree_number => 6, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(6));
    instance_DT7 : DT port map(tree_number => 7, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(7));
    instance_DT8 : DT port map(tree_number => 8, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(8));
    instance_DT9 : DT port map(tree_number => 9, sepal_length => sepal_length, sepal_width => sepal_width, petal_length => petal_length, petal_width => petal_width, class_out => results(9));
  
--delay used to wait for the calculated decision from each of the 10 decision trees
    en <= '1' after 3 ns;
--within the majority vote component the most frequent decision is calculated and given back as finalresult 
    instance_MV  : majorityVote port map(enable => en, a=>results(0), b=>results(1), c=>results(2), d=>results(3), e=>results(4), f=>results(5),
     g=>results(6), h=>results(7), i=>results(8), j=>results(9), class => finalresult);

    class_out <= finalresult;
end Behavioral;
