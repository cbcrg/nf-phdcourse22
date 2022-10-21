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
params.outdir = "results"

log.info """\
        R N A S E Q - N F   P I P E L I N E    
        ===================================
        transcriptome: ${params.transcript}
        reads        : ${params.reads}
        outdir       : ${params.outdir}
        """
        .stripIndent()

read_pairs_ch = Channel.fromFilePairs( params.reads )
