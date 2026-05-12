alter table VIX_P_PRIMARY_DATA drop constraint PK_P_PRIMARY_DATA;
alter table VIX_P_PRIMARY_DATA add constraint PK_P_PRIMARY_DATA primary key (ID_AREA, ID_COMPONENT, START_TIME, ID_VALUE_TYPE);

alter table VIX_S_SECONDARY_DATA drop constraint PK_S_SECONDARY_DATA;
alter table VIX_S_SECONDARY_DATA add constraint PK_S_SECONDARY_DATA primary key (ID_AREA, ID_COMPONENT, START_TIME, ID_AGGREG_TYPE);

exit;
