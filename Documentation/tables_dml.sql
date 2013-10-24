alter table gene.mutect add constraint patient_mutect_idx  


create index on gene.vcf (patient_id, mutation_id, chrom, pos, ref, alt)

vacuum gene.vcf

analyze gene.vcf


select * from gene.vcf

select * from staging.mutect limit 1000


select * from staging.mutect into gene.mutect

drop table gene.mutect

create table gene.mutect(
patient_id integer not null,
contig	character varying,
position integer,	
ref_allele	varchar,
alt_allele	character varying,	
tumor_name	character varying,
normal_name	 character varying,
score	numeric,	
dbsnp_site	character varying,	
covered		varchar,
tumor_power		numeric(10,2),
normal_power	numeric(10,2),	
total_pairs	integer,	
improper_pairs	integer,	
map_Q0_reads	integer,	
t_lod_fstar	numeric(10,2),	
tumor_f	character varying,	
contaminant_fraction	numeric(3,2),	
contaminant_lod	numeric(10,2),	
t_ref_count	integer,	
t_alt_count	integer,	
t_ref_sum	integer,	
t_alt_sum	integer,	
t_ins_count		integer,
t_del_count	integer,	
normal_best_gt	character varying,	
init_n_lod	numeric(10, 2),	
n_ref_count	integer,	
n_alt_count		integer,
n_ref_sum	integer,	
n_alt_sum	integer,	
judgement	character varying);


insert into gene.mutect (patient_id,
contig,
position,
ref_allele,
alt_allele,
tumor_name,
normal_name,
score,
dbsnp_site,
covered,
tumor_power,
normal_power,
total_pairs,
improper_pairs,
map_Q0_reads,
t_lod_fstar,
tumor_f,
contaminant_fraction,
contaminant_lod,
t_ref_count,
t_alt_count,
t_ref_sum,
t_alt_sum,
t_ins_count,
t_del_count,
normal_best_gt,
init_n_lod,
n_ref_count,
n_alt_count,
n_ref_sum,
n_alt_sum,
judgement)
select 1,
contig,
cast(position as integer),
ref_allele,
alt_allele,
tumor_name,
normal_name,
cast(score as float8),
dbsnp_site,
covered,
cast(tumor_power as float8),
cast(normal_power as float8),
cast(total_pairs as integer),
cast(improper_pairs as integer),
cast(map_Q0_reads as integer),
cast(t_lod_fstar as float8),
tumor_f,
cast(contaminant_fraction as float8),
cast(contaminant_lod as float8),
cast(t_ref_count as integer),
cast(t_alt_count as integer),
cast(t_ref_sum as integer),
cast(t_alt_sum as integer),
cast(t_ins_count as integer),
cast(t_del_count as integer),
normal_best_gt,
cast(init_n_lod as float8),
cast(n_ref_count as integer),
cast(n_alt_count as integer),
cast(n_ref_sum as integer),
cast(n_alt_sum as integer),
judgement from staging.mutect

select * from gene.mutect mut, gene.vcf vcf
where mut.patient_id = vcf.patient_id
and vcf.chrom = mut.contig
and vcf.pos = mut.position
and vcf.alt = mut.alt_allele



alter table gene.mutect add constraint patient_mutect_px primary key(patient_id, contig, position, alt_allele)

vacuum gene.mutect

analyze gene.mutect