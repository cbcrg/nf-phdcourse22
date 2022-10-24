/*
 * Create a report using multiQC for the quantification
 * and fastqc processes
 */
process MULTIQC {
    publishDir params.outdir, mode:'copy'

    input:
    path('*')

    output:
    path('multiqc_report.html'), emit: multiqc_report // Optionally, outputs can be named using the emit option

    script:
    """
    multiqc .
    """
}