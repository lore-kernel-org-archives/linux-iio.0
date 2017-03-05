Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35067 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdCEMIN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 07:08:13 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so14470766wrb.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2017 04:08:12 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH] staging: iio: adis16209: Group similar macros into enums
Date: Sun,  5 Mar 2017 14:07:54 +0200
Message-Id: <1488715674-22836-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the macros are related, they should be grouped into an enum
for clarity.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 84 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 8ff537f..706e119 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -104,62 +104,72 @@
 /* Operation, system command register */
 #define ADIS16209_GLOB_CMD       0x3E
 
+#define ADIS16209_ERROR_ACTIVE          BIT(14)
+
 /* MSC_CTRL */
 
-/* Self-test at power-on: 1 = disabled, 0 = enabled */
-#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
+enum adis16209_msc_ctrl {
+	/* Self-test at power-on: 1 = disabled, 0 = enabled */
+	ADIS16209_MSC_CTRL_PWRUP_SELF_TEST = BIT(10),
 
-/* Self-test enable */
-#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
+	/* Self-test enable */
+	ADIS16209_MSC_CTRL_SELF_TEST_EN = BIT(8),
 
-/* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
+	/* Data-ready enable: 1 = enabled, 0 = disabled */
+	ADIS16209_MSC_CTRL_DATA_RDY_EN = BIT(2),
 
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
+	/* Data-ready polarity: 1 = active high, 0 = active low */
+	ADIS16209_MSC_CTRL_ACTIVE_HIGH = BIT(1),
 
-/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
-#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
+	/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
+	ADIS16209_MSC_CTRL_DATA_RDY_DIO2 = BIT(0),
+};
 
 /* DIAG_STAT */
 
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
+enum adis16209_diag_stat {
+	/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
+	ADIS16209_DIAG_STAT_ALARM2 = BIT(9),
 
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
+	/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
+	ADIS16209_DIAG_STAT_ALARM1 = BIT(8),
 
-/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
-#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
+	/* Self-test diagnostic error flag:
+	 * 1 = error condition, 0 = normal operation
+	 */
+	ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT = 5,
 
-/* SPI communications failure */
-#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
+	/* SPI communications failure */
+	ADIS16209_DIAG_STAT_SPI_FAIL_BIT = 3,
 
-/* Flash update failure */
-#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
+	/* Flash update failure */
+	ADIS16209_DIAG_STAT_FLASH_UPT_BIT = 2,
 
-/* Power supply above 3.625 V */
-#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
+	/* Power supply above 3.625 V */
+	ADIS16209_DIAG_STAT_POWER_HIGH_BIT = 1,
 
-/* Power supply below 3.15 V */
-#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
+	/* Power supply below 3.15 V */
+	ADIS16209_DIAG_STAT_POWER_LOW_BIT = 0,
+};
 
 /* GLOB_CMD */
 
-#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
-#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
-
-#define ADIS16209_ERROR_ACTIVE          BIT(14)
+enum adis16209_glob_cmd {
+	ADIS16209_GLOB_CMD_SW_RESET = BIT(7),
+	ADIS16209_GLOB_CMD_CLEAR_STAT = BIT(4),
+	ADIS16209_GLOB_CMD_FACTORY_CAL = BIT(1),
+};
 
-#define ADIS16209_SCAN_SUPPLY	0
-#define ADIS16209_SCAN_ACC_X	1
-#define ADIS16209_SCAN_ACC_Y	2
-#define ADIS16209_SCAN_AUX_ADC	3
-#define ADIS16209_SCAN_TEMP	4
-#define ADIS16209_SCAN_INCLI_X	5
-#define ADIS16209_SCAN_INCLI_Y	6
-#define ADIS16209_SCAN_ROT	7
+enum adis16209_scan {
+	ADIS16209_SCAN_SUPPLY,
+	ADIS16209_SCAN_ACC_X,
+	ADIS16209_SCAN_ACC_Y,
+	ADIS16209_SCAN_AUX_ADC,
+	ADIS16209_SCAN_TEMP,
+	ADIS16209_SCAN_INCLI_X,
+	ADIS16209_SCAN_INCLI_Y,
+	ADIS16209_SCAN_ROT,
+};
 
 static const u8 adis16209_addresses[8][1] = {
 	[ADIS16209_SCAN_SUPPLY] = { },
-- 
1.9.1

