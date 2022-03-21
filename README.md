# RandomForestAccelerator

![alt text](https://www.nvidia.com/content/dam/en-zz/Solutions/glossary/data-science/random-forest/img-3.png)

## Requirements
* **GHDL**
* **GTKWave**
* **VHDL**
* **PYTHON**

## Quick Instruction

### cloning repository

      $ git clone https://github.com/bnna-project/bnna.git  
      $ cd bnna  

### compiling VHDL code and looking on wave diagrams in GTKWave

      $ ghdl -s test_file.vhdl                 #Syntax Check  
      $ ghdl -a test_file.vhdl                 #Analyse  
      $ ghdl -e test_file.vhdl                 #Build   
      $ ghdl -r test_file --vcd=testbench.vcd  #VCD-Dump  
      $ gtkwave testbench.vcd                  #Start GTKWave  

there are two options to compile and run the project. either use VIVADO IDE or compile and run on GTK WAVE. either ways you have to have
VHDL 2008-recent Version for the design to run.
  
      $ bash script.sh test_file.vhdl test_file_testbench.vhdl  
 
Last file must be **testbench** !!! 

### auto compiling the project
In the compile folder is a script to compile all the components automatically. You can use it like this:

      $ cd compile
      $ bash auto_compile.sh

After this you just have to compile the test benches you want to use. For example like this (you should still be in the compile folder):

      $ bash script.sh ../BNNA/tb_presentation.vhdl

## References

1. FP-BNN:  Binarized  neural  network  on  FPGA  
  https://www.sciencedirect.com/science/article/abs/pii/S0925231217315655

2. Stochastic Computing for Hardware Implementationof Binarized Neural Networks  
  https://arxiv.org/abs/1906.00915

3. FINN: A Framework for Fast, Scalable Binarized Neural Network Inference  
  https://arxiv.org/abs/1612.07119
