--{
create or replace function get_min_values(in_date IN char, in_interval IN VARCHAR2)
return number 
DETERMINISTIC
is
begin
-- --------------------------------------------------------------------------
  --
  -- funkce vraci minimalni pocet hodinovych dat pro zapis validnich hodnot.
  -- in_date je datum
  -- in_interval nabyva jedne z techto hodnot: DD nebo MM nebo YYYY
  -- nov
  -- 2026-01-19
  -- --------------------------------------------------------------------------
   declare
      w_date         date;
      w_interval     varchar2(20);
      w_return       number(5,0);
      w_is_leap_year number(1,0);
      w_month        number(2,0);
   begin
      w_date                  := in_date;
      w_interval              := in_interval;
      w_is_leap_year          := 0; --0/1 - nejedna/jedna se o prestupny rok
      w_return                := 0;

      w_is_leap_year := TO_CHAR(LAST_DAY(TO_DATE('02-' || EXTRACT(YEAR FROM w_date), 'MM-YYYY')), 'DD')-28;
      w_month := EXTRACT(MONTH FROM w_date);
      IF w_interval = 'DD' THEN
         w_return := 22;
      ELSIF w_interval = 'MM' THEN
         CASE  
            WHEN w_month in (1,3,5,7,8,10,12) THEN
               w_return := 670;
            WHEN w_month in (4,6,9,11) THEN
               w_return := 648;
            WHEN w_month in (2) THEN
               IF w_is_leap_year = 0 THEN
                  w_return := 605;
               ELSE
                  w_return := 626;
               END IF;
         END CASE;
      ELSIF w_interval = 'YYYY' THEN
         IF w_is_leap_year = 0 THEN
            w_return := 7884;
         ELSE
            w_return := 7906;
         END IF;
      END IF;
      return w_return;
   end;
end get_min_values;
/
--}
grant execute on get_min_values to i_read_role;
exit;