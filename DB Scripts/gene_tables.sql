create schema staging

drop table staging.mutect

create table staging.mutect(
contig	character varying,
position character varying,	
ref_allele	character varying,
alt_allele	character varying,	
tumor_name	character varying,
normal_name	 character varying,
score	character varying,	
dbsnp_site	character varying,	
covered	character varying,
power	character varying,	
tumor_power		character varying,
normal_power	character varying,	
total_pairs	character varying,	
improper_pairs	character varying,	
map_Q0_reads	character varying,	
t_lod_fstar	character varying,	
tumor_f	character varying,	
contaminant_fraction	character varying,	
contaminant_lod	character varying,	
t_ref_count	character varying,	
t_alt_count	character varying,	
t_ref_sum	character varying,	
t_alt_sum	character varying,	
t_ins_count		character varying,
t_del_count	character varying,	
normal_best_gt	character varying,	
init_n_lod	character varying,	
n_ref_count	character varying,	
n_alt_count		character varying,
n_ref_sum	character varying,	
n_alt_sum	character varying,	
judgement	character varying);



select * from staging.vcf_raw;

create schema gene;

drop table gene.vcf

create table gene.vcf(patient_id integer not null, 
mutation_id varchar(10)	not null, 
chrom	varchar(10)	not null, 
pos int	not null, 
ref varchar, 
alt	varchar, 
ac	numeric, 
af	numeric, 
an integer, 
baseqranksum	numeric, 
dp_info	numeric, 
ds	varchar, 
dels varchar, 
fs	numeric, 
haplotypescore	numeric, 
inbreedingcoeff	varchar, 
mleac	numeric, 
mleaf	numeric, 
mq	numeric, 
mq0	numeric, 
mqranksum	numeric, 
qd	numeric, 
rpa	varchar, 
ru	varchar, 
readposranksum	numeric, 
str varchar, 
program varchar)

insert into gene.vcf (patient_id, mutation_id, chrom, pos, ref, 
alt, ac, af, an, baseqranksum, dp_info, 
ds, dels, fs, haplotypescore, inbreedingcoeff, mleac, mleaf, 
mq, mq0, mqranksum, qd, rpa, ru, readposranksum, str, program)
select 
1, 
id, 
chrom, 
to_number((case when pos = '' then '0' else pos end), '99999') as pos, 
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
