# Repositório dedicado à disciplina de Processamento Digital de Sinais

### **Objetivo do Projeto**        :  Implementação e verificação em hardware de um filtro de média móvel

### **Topológia do Filtro**        :  Cascaded Integrator–Comb Filter - CIC

### **Componentes do Projeto**     :  FPGA Cyclone IV, Resistores, Capacitores e um Osciloscópio.

### **Ferramentas**                :  Quartus prime II, Xcelium e o Simvision.



    AlinxModTest.sv -> Modulo topo Quartus Prime II
    
    divClock.sv     -> Divisor de frequência
    
    Integrator.sv   -> Integrador do filtro 
    
    Comb.sv         -> Diferenciador do filtro
    
    PWM.sv         -> Modulação PWM para dac
    
    ->sawtooth_wave.sv portadora
    
    ->cos_wave.sv      modulante
    
    filtro_em_cascata.sv -> Combinação do filtro.

