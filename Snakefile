configfile: "config.yaml"

with open(config['SAMPLES']) as fp:
    SAMPLES= fp.read().splitlines()
print(SAMPLES)

rule all:
      input:
           expand("{sample}_lncRNA_pos_seq_desc", sample = SAMPLES)


rule PLEK:
   input:
        "{sample}.fa"
   params: 
     prefix = "{sample}_lncRNA"
   output:
       "{sample}_lncRNA_pos_seq_desc"
   conda: 'env/env-plek.yaml' 
   shell:
      """
      PLEK -f {input} -o {params.prefix} 
      """
