DROP PROCEDURE IF EXISTS SP_Find_Stocks;

DELIMITER $$
CREATE PROCEDURE SP_Find_Stocks
(
    IN AverageType VARCHAR(20),    -- Type of moving average. Ex SMA, EMA, et
    IN TimeInterval VARCHAR(20),    -- DAILY, WEEKLY, MONTHLY, etc
    IN Direction VARCHAR(20),    -- From above (ABOVE) or below (BELOW)
    IN TimePeriod INT,            -- 10, 20, 50, 100, 200day moving averages
    IN DaysBack INT,            -- How many days back to check
    IN PriceDiff FLOAT,           -- Diff. between MA and stock price		
    OUT StockList VARCHAR(255)	-- List of stocks symbols that match the input criteria.
)
BEGIN
    DECLARE StockSymbol VARCHAR(20);
    DECLARE ValidPattern BOOLEAN;
    DECLARE v_finished INTEGER DEFAULT 0;
    DECLARE Stock_CRSR CURSOR FOR SELECT Symbol FROM STOCK WHERE OPTIONSOFFERED = 'Y';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    SET StockList = '';

    OPEN Stock_CRSR;

    get_stock: LOOP
        FETCH Stock_CRSR INTO StockSymbol;
        IF (v_finished = 1)
        THEN
			LEAVE get_stock;
		END IF;
        
		CALL SP_MovingAverage(StockSymbol, AverageType, TimeInterval, Direction,
								TimePeriod, DaysBack, PriceDiff, ValidPattern);
		IF (ValidPattern = TRUE)
        THEN
			SET StockList = CONCAT(StockList, ";", StockSymbol);
        END IF;
    END LOOP get_stock;
END $$
DELIMITER ;