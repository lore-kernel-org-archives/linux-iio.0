Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-108.synserver.de ([212.40.185.108]:1085 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab3AaO1D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 09:27:03 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] staging:iio:adxrs450: Reflow overlong lines
Date: Thu, 31 Jan 2013 15:27:53 +0100
Message-Id: <1359642478-9622-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1359642478-9622-1-git-send-email-lars@metafoo.de>
References: <1359642478-9622-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reflow two lines to meet the 80 characters per line limit.

Fixes the following checkpatch warnings:
	WARNING: line over 80 characters
	#29: FILE: staging/iio/gyro/adxrs450_core.c:29:
	+ * @reg_address: the address of the lower of the two registers,which should be an even address,

	WARNING: line over 80 characters
	#81: FILE: staging/iio/gyro/adxrs450_core.c:81:
	+ * @reg_address: the address of the lower of the two registers,which should be an even address,

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adxrs450_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 24b7a0f..dd0b744 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -26,8 +26,8 @@
 /**
  * adxrs450_spi_read_reg_16() - read 2 bytes from a register pair
  * @dev: device associated with child of actual iio_dev
- * @reg_address: the address of the lower of the two registers,which should be an even address,
- * Second register's address is reg_address + 1.
+ * @reg_address: the address of the lower of the two registers, which should be
+ *	an even address, the second register's address is reg_address + 1.
  * @val: somewhere to pass back the value read
  **/
 static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
@@ -78,8 +78,8 @@ error_ret:
 /**
  * adxrs450_spi_write_reg_16() - write 2 bytes data to a register pair
  * @dev: device associated with child of actual actual iio_dev
- * @reg_address: the address of the lower of the two registers,which should be an even address,
- * Second register's address is reg_address + 1.
+ * @reg_address: the address of the lower of the two registers,which should be
+ *	an even address, the second register's address is reg_address + 1.
  * @val: value to be written.
  **/
 static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
-- 
1.8.0

