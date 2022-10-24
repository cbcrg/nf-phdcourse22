/* 
 * include required modules
 */
include { SALMON_INDEX          } from '../modules/salmon_modules.nf'
include { SALMON_QUANTIFICATION } from '../modules/salmon_modules.nf'

/* 
 * define the data analysis workflow
 */
workflow SALMON_INDEX_QUANTIFICATION {
    
    // required inputs
    take:
    transcriptome
    read_files

    // workflow implementation
    main:
    SALMON_INDEX(transcriptome)
    SALMON_QUANTIFICATION(
        SALMON_INDEX.out, read_files)
    
    emit:
    salmon_results = SALMON_QUANTIFICATION.out.results
}
