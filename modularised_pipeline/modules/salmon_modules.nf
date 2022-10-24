/* 
 * define the `index` process that create a binary index 
 * given the transcriptome file
 */
process SALMON_INDEX {
    
    input:
    path transcriptome

    output:
    path 'index', emit: index

    script:       
    """
    salmon index --threads $task.cpus -t $transcriptome -i index
    """
}

/*
 * Run Salmon to perform the quantification of expression using
 * the index and the matched read files
 */
process SALMON_QUANTIFICATION {

    input:
    path index
    tuple val(pair_id), path(reads)

    output:
    path(pair_id), emit: results

    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}
