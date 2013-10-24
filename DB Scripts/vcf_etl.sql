-- VCF v4.1 formatted files

insert into gene.vcf (patient_id, mutation_id, chrom, pos, ref, 
alt, ac, af, an, baseqranksum, dp_info, 
ds, dels, fs, haplotypescore, inbreedingcoeff, mleac, mleaf, 
mq, mq0, mqranksum, qd, rpa, ru, readposranksum, str, program)
select 
1, 
id, 
chrom, 
to_number(pos, '9999999999'), 
ref, 
trim(alt, '[]'), 
to_number(trim(ac, '[]'), '99G999D9S') as ac, 
to_number(trim(af, '[]'), '99999D9999') as af, 
to_number(an, '99999') as an, 
to_number((case when baseq = '' then '0.0' else baseq end), '99999D9999') as baseqranksum, 
to_number(dp, '99999D9999') as dp_info, 
ds, 
dels, 
to_number((case when fs = '' then '0.0' else fs end), '999999D999999') as fs, 
to_number(hapscore, '99999D9999') as haplotypescore, 
inbreedingcoeff, 
to_number(trim(mleac, '[]'), '9999') as mleac, 
to_number(trim(mleaf, '[]'), '99D9999') as mleaf, 
to_number(mq, '99999D9999') as mq, 
to_number(mq0, '9999D99') as mq0, 
to_number((case when mqranksum = '' then '0.0' else mqranksum end), '9999D9999') as  mqranksum, 
to_number(qd, '9999D9999') as qd, 
trim(rpa, '[]'), 
ru, 
to_number((case when readsum = '' then '0.0' else readsum end), '99999D9999') as readposranksum, 
str_vcf, 
'vcf-4.1'
from staging.vcf_raw;


-- Mu tect formatted files

insert into gene_data.vcf1 (patient_id, mutation_id, chrom, pos, ref, 
alt, covered, power, tumor_power, total_pairs, improper_pairs, map_q0_reads, t_lod_fstar, contaminant_fraction, t_ref_count, t_alt_count,
t_ref_sum, t_alt_sum, t_ins_count, t_del_count, normal_best_gt, init_n_lod, n_ref_count, n_alt_count, n_ref_sum, n_alt_sum, judgement,
program)
select 2, tumor_name, contig, to_number(position, '9999999999') as pos, ref_allele, alt_allele, covered, 
to_number(power, '99D9999999') as power, to_number(tumor_power, '99D99999') as tumor_power, 
to_number(total_pairs, '999999') as total_pairs, to_number(improper_pairs, '999999') as improper_pairs, 
to_number(map_q0_reads, '999999') as map_q0_reads, to_number(t_lod_fstar, '9999D9999999') as t_lod_fstar, 
to_number(contaminant_fraction, '99D99999') as contaminant_fraction, to_number(t_ref_count, '999999') as t_ref_count, 
to_number(t_alt_count, '999999') as t_alt_count, to_number(t_ref_count, '999999') as t_ref_sum, to_number(t_alt_sum, '999999') as t_alt_sum, 
to_number(t_ins_count, '999999') as t_ins_count, to_number(t_del_count, '999999') as t_del_count, normal_best_gt, 
to_number((case when init_n_lod  is null then '0.0' else init_n_lod end), '9999D99999') as init_n_lod, to_number(n_ref_count, '999999') as n_ref_count, to_number(n_alt_count, '999999') as n_alt_count, 
to_number(t_ref_sum, '999999') as n_ref_sum,  to_number(t_alt_sum, '999999') as n_alt_sum, judgement, 'mutect'
from staging.mutect

vacuum analyse gene_data.vcf



