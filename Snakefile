configfile: "config.yaml"

with open(config['SAMPLES']) as fp:
    SAMPLES= fp.read().splitlines()
print(SAMPLES)

rule all:
   input:
        expand("{genome}.1.ebwt", genome = config['PREFIX']),
        expand("{genome}.2.ebwt", genome = config['PREFIX']),
        expand("{genome}.3.ebwt", genome = config['PREFIX']),
        expand("{genome}.4.ebwt", genome = config['PREFIX']),
        expand("{genome}.rev.1.ebwt", genome = config['PREFIX']),
        expand("{genome}.rev.2.ebwt", genome = config['PREFIX']),
        expand("{sample}.sam", sample = SAMPLES),


rule download_mirbase:
    output: 
        expand("{mature}", mature = config['miRNA'])
    shell: 
        """
        wget https://mirbase.org/ftp/CURRENT/mature.fa.gz 
        gunzip -c mature.fa.gz > {output}
        """

rule bowtie_index:
    input:
       genome = expand("{mature}", mature = config['miRNA']), 
    params:  
       PREFIX = config['PREFIX']
    output:  
       expand("{prefix}.1.ebwt", prefix = config['PREFIX']),
       expand("{prefix}.2.ebwt", prefix = config['PREFIX']), 
       expand("{prefix}.3.ebwt", prefix = config['PREFIX']),
       expand("{prefix}.4.ebwt", prefix = config['PREFIX']),
       expand("{prefix}.rev.1.ebwt", prefix = config['PREFIX']), 
       expand("{prefix}.rev.2.ebwt", prefix = config['PREFIX'])
    conda: 'env/env-bowtie.yaml'
    shell: 
       """
       bowtie-build {input.genome} {params.PREFIX}  
       """

if config['PAIRED']: 
    rule trim:
       input:
          r1 = "{sample}.r_1.fq.gz",
          r2 = "{sample}.r_2.fq.gz"
       log: "logs/{sample}.trim.log"
       benchmark: "logs/{sample}.trim.benchmark"
       conda :'env/env-trim.yaml'
       output:
          val1 = "fastp/{sample}.r_1_val_1.fq.gz",
          val2 = "fastp/{sample}.r_2_val_2.fq.gz",
          html = "fastp/{sample}.quality.html"
       shell:
          """
           mkdir -p fastp
           fastp --in1 {input.r1} --in2 {input.r2} --out1 {output.val1} --out2 {output.val2} -l 50 -h {output.html} -g &> {log}
          """
    rule bowtie: 
       input: 
         "fastp/{sample}.r_1_val_1.fq.gz",
         "fastp/{sample}.r_2_val_2.fq.gz",
       params: 
         PREFIX = config['PREFIX']
       conda: 'env/env-bowtie.yaml' 
       output: 
         "{sample}.sam" 
       shell: 
         """
         bowtie -x {params.PREFIX} -1 {input[0]} -2 {input[1]} 
         """ 
else: 
    rule trim:
       input:
          "{sample}.fq.gz",
       log: "logs/{sample}.trim.log"
       benchmark: "logs/{sample}.trim.benchmark"
       conda :'env/env-trim.yaml'
       output:
          val1 = "fastp/{sample}.trimmed.fq.gz",
          html = "fastp/{sample}.quality.html"
       shell:
          """
           mkdir -p fastp
           fastp --in1 {input}  --out1 {output.val1} -l 50 -h {output.html} -g &> {log}
          """
    rule bowtie:
        input:
          "fastp/{sample}.trimmed.fq.gz",
        params:
          PREFIX = config['PREFIX']
        output:
           "{sample}.sam"
        conda: 'env/env-bowtie.yaml'
        shell:
         """
         bowtie -x {params.PREFIX} {input[0]} 
         """

