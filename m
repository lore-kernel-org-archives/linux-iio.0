Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38388 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeCPUGz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Mar 2018 16:06:55 -0400
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, 21cnbao@gmail.com,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH v2 1/9] Staging: iio: accel: adis16201: Rename few macro definitions
Date: Sat, 17 Mar 2018 01:36:18 +0530
Message-Id: <1521230786-18155-2-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rename the macro definitions with suitable names specifying their
purpose.

* ADIS16201_STARTUP_DELAY_MS: Remove the comment specifying the delay in
  microseconds and rename it with addtition of _MS suffix.

* ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH: Rename the macro to make it
  similar to other misc control registers which denotes the data ready
  polarity.

* ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT: Rename to denote it is a
  failure bit.

* ADIS16201_GLOB_CMD_FACTORY_RESET: Remove ambiguous _CAL suffix and add
  _RESET suffix instead to denote factory reset command.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
v2:
   -explained every change in the process of renaming macros. 

 drivers/staging/iio/accel/adis16201.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0fae8aa..767ebf0 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -20,7 +20,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16201_STARTUP_DELAY	220 /* ms */
+#define ADIS16201_STARTUP_DELAY_MS	220
 
 /* Flash memory write count */
 #define ADIS16201_FLASH_CNT      0x00
@@ -118,7 +118,7 @@
 #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
 
 /* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
+#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
 
 /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
 #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
@@ -135,7 +135,7 @@
 #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
 
 /* Flash update failure */
-#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
+#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
 
 /* Power supply above 3.625 V */
 #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
@@ -146,7 +146,7 @@
 /* GLOB_CMD */
 
 #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
+#define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)
 
 #define ADIS16201_ERROR_ACTIVE          BIT(14)
 
@@ -290,7 +290,7 @@ static const struct iio_info adis16201_info = {
 
 static const char * const adis16201_status_error_msgs[] = {
 	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
+	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
 	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
 	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
 };
@@ -303,11 +303,11 @@ static const struct adis_data adis16201_data = {
 
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16201_STARTUP_DELAY,
+	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
 
 	.status_error_msgs = adis16201_status_error_msgs,
 	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
+		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
 		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
 		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
 };
-- 
2.7.4

