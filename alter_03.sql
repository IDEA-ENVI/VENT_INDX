alter table vix_c_aggreg_type add column_name varchar2(30);
update vix_c_aggreg_type set column_name='VI_průměr_m²·s⁻¹' where fixed_id=1;
update vix_c_aggreg_type set column_name='VI_průměr_m²·s⁻¹' where fixed_id=2;
update vix_c_aggreg_type set column_name='VI_průměr_m²·s⁻¹' where fixed_id=3;

update vix_c_aggreg_type set column_name='VI_VD_%' where fixed_id=4;
update vix_c_aggreg_type set column_name='VI_D_%' where fixed_id=5;
update vix_c_aggreg_type set column_name='VI_MN_%' where fixed_id=6;
update vix_c_aggreg_type set column_name='VI_N_%' where fixed_id=7;

update vix_c_aggreg_type set column_name='VI_VD_%' where fixed_id=8;
update vix_c_aggreg_type set column_name='VI_D_%' where fixed_id=9;
update vix_c_aggreg_type set column_name='VI_MN_%' where fixed_id=10;
update vix_c_aggreg_type set column_name='VI_N_%' where fixed_id=11;

update vix_c_aggreg_type set column_name='VI_VD_%' where fixed_id=12;
update vix_c_aggreg_type set column_name='VI_D_%' where fixed_id=13;
update vix_c_aggreg_type set column_name='VI_MN_%' where fixed_id=14;
update vix_c_aggreg_type set column_name='VI_N_%' where fixed_id=15;

update vix_c_aggreg_type set column_name='T2m_průměr_K' where fixed_id=16;
update vix_c_aggreg_type set column_name='T2m_průměr_K' where fixed_id=17;
update vix_c_aggreg_type set column_name='T2m_průměr_K' where fixed_id=18;

alter table vix_c_aggreg_type modify column_name not null;
exit;