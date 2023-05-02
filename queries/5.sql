SELECT `al`.`airline`,
       `ap`.`airport`,
       COUNT(*) AS `volume`,
       AVG(`arr_delay`) AS `avg_arrival_delay`
FROM `flights` `f`
JOIN `airlines` `al` ON `f`.`carrier` = `al`.`iata_code`
JOIN `airports` `ap` ON `f`.`dest` = `ap`.`iata_code`
WHERE `ap`.`state` = 'CA'
    AND `f`.`year` = 2020 GROUP  BY 1,
                                    2
    ORDER  BY 1,
              2;
