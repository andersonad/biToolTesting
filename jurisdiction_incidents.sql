create TABLE IF not exists jurisdiction_incidents  as (
  SELECT jurname, count(b.geom) as incidents
  FROM sf_jurisdictions a
  LEFT JOIN fire_incident b ON st_contains(a.geom, b.geom)
  GROUP BY jurname
  );
