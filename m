Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1122 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab3AaO1H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:07 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/11] staging:iio:adxrs450: Fixup kernel doc comments
Date: Thu, 31 Jan 2013 15:27:56 +0100
Message-Id: <1359642478-9622-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the name of the iio_device parameter for a few functions and add
documentation for one missing function parameter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 4115fe1..714e323 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -25,7 +25,7 @@
 
 /**
  * adxrs450_spi_read_reg_16() - read 2 bytes from a register pair
- * @dev: device associated with child of actual iio_dev
+ * @indio_dev: device associated with child of actual iio_dev
  * @reg_address: the address of the lower of the two registers, which should be
  *	an even address, the second register's address is reg_address + 1.
  * @val: somewhere to pass back the value read
@@ -77,7 +77,7 @@ error_ret:
 
 /**
  * adxrs450_spi_write_reg_16() - write 2 bytes data to a register pair
- * @dev: device associated with child of actual actual iio_dev
+ * @indio_dev: device associated with child of actual actual iio_dev
  * @reg_address: the address of the lower of the two registers,which should be
  *	an even address, the second register's address is reg_address + 1.
  * @val: value to be written.
@@ -108,7 +108,7 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
 
 /**
  * adxrs450_spi_sensor_data() - read 2 bytes sensor data
- * @dev: device associated with child of actual iio_dev
+ * @indio_dev: device associated with child of actual iio_dev
  * @val: somewhere to pass back the value read
  **/
 static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
@@ -152,6 +152,7 @@ error_ret:
  * adxrs450_spi_initial() - use for initializing procedure.
  * @st: device instance specific data
  * @val: somewhere to pass back the value read
+ * @chk: Whether to perform fault check
  **/
 static int adxrs450_spi_initial(struct adxrs450_state *st,
 		u32 *val, char chk)
-- 
1.8.0

