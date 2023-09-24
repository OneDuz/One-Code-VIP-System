CREATE TABLE `onecodesvip` (
  `license` varchar(46) NOT NULL,
  `Granted` varchar(250) DEFAULT NULL,
  `Expires` varchar(250) DEFAULT NULL,
  `LeftDays` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `onecodesvip`
  ADD PRIMARY KEY (`license`);
COMMIT;
