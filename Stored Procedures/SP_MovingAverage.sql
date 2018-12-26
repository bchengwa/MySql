DROP PROCEDURE IF EXISTS sp_MovingAverage;
SET GLOBAL general_log = 1;

DELIMITER //

CREATE PROCEDURE sp_MovingAverage
(
    IN StockSymbol  VARCHAR(20),  -- Stock Symbol
    IN AverageType  VARCHAR(20),    -- Type of moving average. Ex SMA, EMA, et
    IN timeInterval VARCHAR(20),    -- DAILY, WEEKLY, MONTHLY, etc
    IN Direction    VARCHAR(20),    -- From above (ABOVE) or below (BELOW)
    IN TimePeriod   INT,            -- 10, 20, 50, 100, 200day moving averages
    IN DaysBack     INT,            -- How many days back to check
    IN PriceDiff    FLOAT,          -- Diff. between MA and stock price
    OUT ValidPattern BOOLEAN     -- Cursor with list of stocks that match provided criteria
)
BEGIN

    DECLARE CurrentDate DATE DEFAULT CURDATE();
    DECLARE StockPrice VARCHAR(20);
    DECLARE StartDate   DATE;
    DECLARE l_MovingAverageValue DECIMAL;
    DECLARE l_ClosingPrice DECIMAL;
	DECLARE required_inputs_not_received CONDITION FOR SQLSTATE '45000';
	DECLARE symbol_not_found CONDITION FOR SQLSTATE '45001';
    DECLARE finished INTEGER DEFAULT 0;
	
    DECLARE MovingAverage_CRSR  Cursor FOR
		SELECT MA.MovingAverageValue, HP.ClosingPrice
		FROM MovingAverage MA, HistoricalPrices HP
		WHERE MA.Symbol = HP.Symbol
		AND MA.MovingAverageDate = HP.ClosingDate
        AND MA.Symbol = StockSymbol
		AND	MA.AverageType = AverageType
        AND MA.TimeInterval = timeInterval
        AND MA.TimePeriod =  TimePeriod
        AND MA.MovingAverageDate > StartDate
        AND HP.ClosingDate > StartDate
        ORDER BY MA.MovingAverageDate ASC;
        
	DECLARE CONTINUE HANDLER FOR
    NOT FOUND SET finished = TRUE;
    
	SET StartDate = CurrentDate - DaysBack;
    SET ValidPattern = 1;
    
  /*  SELECT Price
    INTO StockPrice 
    FROM StockDetails
    WHERE Symbol = StockSymbol;
    
    IF (StockPrice IS NULL)
    THEN
		SIGNAL symbol_not_found;
    END IF;
    
	IF ((StockSymbol IS NULL) OR
		(AverageType IS NULL) OR
        (timeInterval IS NULL) OR
        (TimePeriod IS NULL) OR
		(DaysBack IS NULL) OR
        (Direction IS NULL))
    THEN
        SIGNAL required_inputs_not_received;
    END IF;*/
    
	OPEN MovingAverage_CRSR;

    check_movingaverage: LOOP
		FETCH MovingAverage_CRSR INTO l_MovingAverageValue, l_ClosingPrice;
		IF (finished = 1)
		THEN
			LEAVE check_movingaverage;
		END IF;

		IF (Direction = 'BELOW')
		THEN
			IF (l_ClosingPrice > l_MovingAverageValue)
            THEN
				SET ValidPattern  = FALSE;
			END IF;
		ELSE
			IF (l_ClosingPrice < l_MovingAverageValue)
            THEN
				SET ValidPattern  = FALSE;
			END IF;
		END IF;
    END LOOP check_movingaverage;

    CLOSE MovingAverage_CRSR;
END //
DELIMITER SP_Find_Stockssp_MovingAverage;