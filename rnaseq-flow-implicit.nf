nextflow.enable.dsl=2

/* 
 * include required modules
 */
include { index; quantification; fastqc; multiqc  } from './rnaseq-modules.nf'

// params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
// params.transcript = "$projectDir/data/ggal/transcriptome.fa"
// params.multiqc = "$projectDir/multiqc"
// params.outdir = "results"

log.info """\
        Params in subworkflow are inhereted    
        ===================================
        transcriptome: ${params.transcript}
        reads        : ${params.reads}
        outdir       : ${params.outdir}
        """
        .stripIndent()

// read_pairs_ch = Channel.fromFilePairs( params.reads, checkIfExists:true )

/* 
 * define the data analysis workflow 
 */
workflow rnaseq_flow {
    // required inputs
    take:
    transcriptome
    read_files

    // workflow implementation
    main:
    index(transcriptome)
    quantification(index.out, read_files)
    fastqc(read_files)
    multiqc( quantification.out.mix(fastqc.out).collect() )
}

/* 
 * Invocation of the data analysis workflow 
 */
workflow {
    rnaseq_flow( params.transcript, read_pairs_ch )
}