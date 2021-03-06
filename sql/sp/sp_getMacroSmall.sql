DELIMITER //
DROP PROCEDURE IF EXISTS sp_getMacroSmall //
CREATE PROCEDURE sp_getMacroSmall
(IN p_country VARCHAR(40), IN p_year int(11))
BEGIN
	SELECT DISTINCT 
		c.country_name 'country', c2.conflict_year 'year', 
		SUM(c2.fatalities) AS 'sum fatalities', Cast(ROUND(m.population/1000) as char) 'population / T'
    
	FROM 
		Country c, Conflict c2, Macro m

	WHERE 
		c.country_id = c2.country_id AND m.country_id = c2.country_id
		AND m.macro_year = c2.conflict_year
		AND IF(p_country = '*', c.country_name LIKE '%', c.country_name = p_country)
		AND IF(p_year = 0, c2.conflict_year , c2.conflict_year = p_year)

	GROUP BY c2.country_id, c.country_name, c2.conflict_year, m.population
	
    ORDER BY c.country_name, c2.conflict_year;
END //
DELIMITER ;