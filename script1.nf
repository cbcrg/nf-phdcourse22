/* 
 * This code enables the new dsl of Nextflow. 
 */
 
nextflow.enable.dsl=2

/* 
 * pipeline input parameters 
 */
params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
params.transcript = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"

println "reads: $params.reads"

