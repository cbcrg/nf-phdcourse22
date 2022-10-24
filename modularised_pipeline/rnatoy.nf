/* 
 * Example showing pipeline modularizaion 
 * Using Nextfloq DSL2
 */ 
nextflow.enable.dsl=2

/* 
 * pipeline input parameters 
 */
// Parameters can also be declared in the configuration
// params.reads      = "$projectDir/data/ggal/gut_{1,2}.fq"
// params.transcript = "$projectDir/data/ggal/transcriptome.fa"
// params.outdir     = "./results"

log.info """\
        R N A S E Q - N F   P I P E L I N E    
        ===================================
        transcriptome: ${params.transcript}
        reads        : ${params.reads}
        outdir       : ${params.outdir}
        """
        .stripIndent()

/* 
 * include required modules
 */
include { FASTQC  } from './modules/fastqc.nf'
include { MULTIQC } from './modules/multiqc.nf'

/* 
 * include required subworkflows
 */
include { SALMON_INDEX_QUANTIFICATION } from './workflows/salmon_index_quantification.nf'


read_pairs_ch = Channel.fromFilePairs( params.reads, checkIfExists:true )

workflow {
    SALMON_INDEX_QUANTIFICATION( params.transcript, read_pairs_ch )
    
    FASTQC( read_pairs_ch )

    MULTIQC( 
        SALMON_INDEX_QUANTIFICATION
            .out
            .salmon_results
            .mix(FASTQC.out)
            .collect() 
    )
}

// This part will be ignore when included as a sub-workflow
// workflow {
//     RNATOY ()
// }