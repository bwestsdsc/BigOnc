create table staging.mutect_raw(
contig	varchar,
position varchar,	
ref_allele	varchar,
alt_allele	varchar,	
tumor_name	varchar,
normal_name	 varchar,
score	varchar,	
dbsnp_site	varchar,	
covered varchar,
power	varchar,	
tumor_power		varchar,
normal_power	varchar,	
total_pairs	varchar,	
improper_pairs	varchar,	
map_Q0_reads	varchar,	
t_lod_fstar	varchar,	
tumor_f	varchar,	
contaminant_fraction	varchar,	
contaminant_lod	varchar,	
t_ref_count	varchar,	
t_alt_count	varchar,	
t_ref_sum	varchar,	
t_alt_sum	varchar,	
t_ins_count		varchar,
t_del_count	varchar,	
normal_best_gt	varchar,	
init_n_lod	varchar,	
n_ref_count	varchar,	
n_alt_count		varchar,
n_ref_sum	varchar,	
n_alt_sum	varchar,	
judgement	varchar);


contig	position	ref_allele	alt_allele	tumor_name	normal_name	score	dbsnp_site	covered_power	tumor_power	normal_power	10
total_pairs	improper_pairs	map_Q0_reads	t_lod_fstar	tumor_f	contaminant_fraction	contaminant_lod	t_ref_count	t_alt_count	t_ref_sum	
t_alt_sum	t_ins_count	t_del_count	normal_best_gt	init_n_lod	n_ref_count	n_alt_count	n_ref_sum	n_alt_sum	judgement


create table vcf_raw(
id	character varying, 
chrom	character varying, 
pos	character varying, 
ref	character varying, 
alt character varying, 
ad character varying, 
dp_format	character varying, 
gq	character varying,
gt	character varying,
mlpsac	character varying, 
mlpsaf	character varying,
pl	character varying, 
ac	character varying, 
af	character varying,
an	character varying,
baseQ	character varying, 
dp	character varying, 
ds	character varying, 
dels	character varying,
fs	character varying, 
hapScore	character varying, 
inbreedingCoeff	character varying, 
mleac	character varying, 
mleaf	character varying, 
mq	character varying, 
mq0		character varying,
mqRankSum	character varying, 
qd	character varying, 
rpa	character varying,	 
ru	character varying, 
readSum	character varying, 
str_vcf character varying)