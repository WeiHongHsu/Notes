	DECLARE
	@isbn10 VARCHAR(10) = '9576941431',
    @isbn13 VARCHAR(13) 

    -- 添加前缀 "978"
    SET @isbn13 = '978' + LEFT(@isbn10, 9);

    -- 计算校验位
    DECLARE @checksum INT;
    SET @checksum = 10 - 
					((1 * CONVERT(INT, SUBSTRING(@isbn13, 1, 1)) +
                      3 * CONVERT(INT, SUBSTRING(@isbn13, 2, 1)) +
                      1 * CONVERT(INT, SUBSTRING(@isbn13, 3, 1)) +
                      3 * CONVERT(INT, SUBSTRING(@isbn13, 4, 1)) +
                      1 * CONVERT(INT, SUBSTRING(@isbn13, 5, 1)) +
                      3 * CONVERT(INT, SUBSTRING(@isbn13, 6, 1)) +
                      1 * CONVERT(INT, SUBSTRING(@isbn13, 7, 1)) +
                      3 * CONVERT(INT, SUBSTRING(@isbn13, 8, 1)) +
                      1 * CONVERT(INT, SUBSTRING(@isbn13, 9, 1)) +
					  3 * CONVERT(INT, SUBSTRING(@isbn13, 10, 1)) +
                      1 * CONVERT(INT, SUBSTRING(@isbn13, 11, 1)) +
					  3 * CONVERT(INT, SUBSTRING(@isbn13, 12, 1)) 
					  ) % 10)

    -- 计算并追加校验位
    select @isbn13 + CAST( @checksum AS VARCHAR(1));
